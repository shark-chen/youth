import 'package:youth/base/base_controller.dart';
import 'package:youth/config/environment_config/app_config.dart';
import 'package:youth/network/net/entry/auxiliary/auxiliary.dart';

/// 行政区节点（尽量兼容接口字段命名）
class _AreaNode {
  _AreaNode({
    required this.id,
    required this.pid,
    required this.name,
    this.level,
    this.type,
  });

  final String id;
  final String pid;
  final String name;
  final int? level;
  final String? type;

  static _AreaNode? fromDynamic(dynamic item) {
    if (item is! Map) return null;
    final map = item.cast<String, dynamic>();

    String? id = _pickStr(map, const [
      'id',
      'areaId',
      'area_id',
      'code',
      'areaCode',
      'area_code',
      '_id'
    ]);

    String? pid = _pickStr(map, const [
      'pid',
      'pId',
      'parentId',
      'parent_id',
      'areaPid',
      'parentCode',
      'parent_code'
    ]);

    final name = _pickStr(map, const [
      'name',
      'areaName',
      'area_name',
      'title',
      'label',
      'text',
      'regionName'
    ]);

    if (id == null || name == null) return null;

    // pid 为空时兜底成根节点（但仍保留原始字符串，方便调试）
    pid ??= '';

    final level = _pickInt(map, const [
      'level',
      'areaLevel',
      'area_level',
      'grade'
    ]);

    final type = _pickStr(map, const ['type', 'areaType', 'area_type']);

    return _AreaNode(
      id: id,
      pid: pid,
      name: name,
      level: level,
      type: type,
    );
  }

  static String? _pickStr(Map<String, dynamic> map, List<String> keys) {
    for (final k in keys) {
      final v = map[k];
      if (v == null) continue;
      if (v is String && v.trim().isNotEmpty) return v.trim();
      if (v is num) return v.toString();
    }
    return null;
  }

  static int? _pickInt(Map<String, dynamic> map, List<String> keys) {
    for (final k in keys) {
      final v = map[k];
      if (v == null) continue;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim());
    }
    return null;
  }

  @override
  String toString() => '$_AreaNode($name, $id, pid=$pid, level=$level)';
}

class CitySelectController extends BaseController {
  final requesting = false.obs;

  /// 加载完成后用于构建树
  late final Map<String, List<_AreaNode>> _childrenByPid;
  late final List<_AreaNode> _provinceList;

  final Rxn<_AreaNode> province = Rxn<_AreaNode>();
  final Rxn<_AreaNode> city = Rxn<_AreaNode>();
  final Rxn<_AreaNode> area = Rxn<_AreaNode>(); // 区/县级市（最终选择）

  final options = <_AreaNode>[].obs;
  final loadFailed = false.obs;
  final loadErrorMsg = ''.obs;

  bool get _cityIsLeaf {
    final c = city.value;
    if (c == null) return false;
    return _isDistrictOrCountyCity(c);
  }

  @override
  void onInit() async {
    super.onInit();
    title = '选择地区';
    _childrenByPid = <String, List<_AreaNode>>{};
    _provinceList = <_AreaNode>[];
    _optionsToProvince();
    await _loadAreaTree();
  }

  /// 只在中国（大陆）地区选择：过滤港澳台
  bool _isMainlandChinaProvince(_AreaNode node) {
    final n = node.name;
    final blocked = ['香港', '澳门', '台湾', '海外'];
    return !blocked.any((k) => n.contains(k));
  }

  /// 区/县级市：尽量基于 level + 名称后缀兜底
  bool _isDistrictOrCountyCity(_AreaNode node) {
    final name = node.name;
    final level = node.level;

    // 有 level 时，倾向认为 >=3 才是区/县级市层级
    if (level != null && level < 3) return false;

    // 明确规则：区；县级市（可能直接写“县级市”，也可能只有“市”）
    if (name.endsWith('区')) return true;
    if (name.contains('县级市')) return true;

    // 县级市通常也是“XX市”，但“地级市”不应出现在这里：如果没有 level，就通过父层级判断。
    if (level != null) {
      // level>=3 时，允许“市”，排除“县”
      if (name.endsWith('市') && !name.endsWith('县')) return true;
      return false;
    }

    // 无 level 兜底：至少不要是“县”
    if (name.endsWith('市') && !name.endsWith('县')) return true;
    return false;
  }

  bool _hasLeafChild(_AreaNode node) {
    final direct = _childrenByPid[node.id] ?? const <_AreaNode>[];
    if (direct.any(_isDistrictOrCountyCity)) return true;

    // 兼容 level 字段缺失：再往下看一层
    for (final child in direct) {
      final grand = _childrenByPid[child.id] ?? const <_AreaNode>[];
      if (grand.any(_isDistrictOrCountyCity)) return true;
    }
    return false;
  }

  void _optionsToProvince() {
    options.clear();
  }

  void _setOptions(List<_AreaNode> list) {
    options.assignAll(list);
  }

  Future<void> _loadAreaTree() async {
    try {
      requesting.value = true;
      loadFailed.value = false;
      loadErrorMsg.value = '';

      final result = await Net.value<Auxiliary>().get<dynamic>(
        AppConfig.getSiteAreaByPid,
      );

      final raw = result.data;

      final rawList = <dynamic>[];
      if (raw is List) {
        rawList.addAll(raw);
      } else if (raw is Map) {
        // 兼容 data 外层包了一层
        final values = raw['data'] ?? raw['values'] ?? raw['list'];
        if (values is List) rawList.addAll(values);
      }

      final nodes = <_AreaNode>[];
      for (final item in rawList) {
        final n = _AreaNode.fromDynamic(item);
        if (n != null) nodes.add(n);
      }

      if (nodes.isEmpty) {
        loadFailed.value = true;
        loadErrorMsg.value = '地区数据为空';
        requesting.value = false;
        _optionsToProvince();
        return;
      }

      _childrenByPid = <String, List<_AreaNode>>{};
      for (final node in nodes) {
        _childrenByPid.putIfAbsent(node.pid, () => <_AreaNode>[]).add(node);
      }

      // provinces：pid 为根的节点（兜底：level==1）
      const rootPidCandidates = <String>{'0', '-1', '', 'null', 'undefined'};
      final provincesCandidate = nodes
          .where((n) => rootPidCandidates.contains(n.pid))
          .toList(growable: false);
      final provincesByLevel =
          nodes.where((n) => (n.level ?? 0) == 1).toList(growable: false);

      final provinces = (provincesCandidate.isNotEmpty
              ? provincesCandidate
              : provincesByLevel)
          .where(_isMainlandChinaProvince)
          .where((n) => _hasLeafChild(n))
          .toList(growable: false);

      // 去重
      final unique = <String, _AreaNode>{};
      for (final p in provinces) {
        unique[p.id] = p;
      }
      _provinceList = unique.values.toList(growable: false);

      // 初始化选项为省列表
      province.value = null;
      city.value = null;
      area.value = null;
      _setOptions(_provinceList);
    } catch (e) {
      loadFailed.value = true;
      loadErrorMsg.value = '地区加载失败：$e';
    } finally {
      requesting.value = false;
    }
  }

  void onTapProvince(_AreaNode node) {
    province.value = node;
    city.value = null;
    area.value = null;

    final next = (_childrenByPid[node.id] ?? const <_AreaNode>[])
        .where((n) => n.name.isNotEmpty)
        .where((n) => _isDistrictOrCountyCity(n) || _hasLeafChild(n))
        .toList(growable: false);
    _setOptions(next);
  }

  void onTapCity(_AreaNode node) {
    city.value = node;
    if (_isDistrictOrCountyCity(node)) {
      area.value = node; // 直接到区/县级市完成
      return;
    }
    area.value = null;

    final next = (_childrenByPid[node.id] ?? const <_AreaNode>[])
        .where(_isDistrictOrCountyCity)
        .toList(growable: false);
    // 如果只有非 leaf 直接子节点，兜底往下一层找 leaf
    if (next.isEmpty) {
      final candidates = <_AreaNode>[];
      for (final child in _childrenByPid[node.id] ?? const <_AreaNode>[]) {
        candidates.addAll(
          (_childrenByPid[child.id] ?? const <_AreaNode>[])
              .where(_isDistrictOrCountyCity),
        );
      }
      _setOptions(candidates);
    } else {
      _setOptions(next);
    }
  }

  void onTapArea(_AreaNode node) {
    area.value = node;
  }

  /// 当前列表对应的层级：
  /// 0=省；1=市/区/县级市（如果当前 city 直接是 leaf）；2=区/县级市
  int get currentLevel {
    if (province.value == null) return 0;
    if (city.value == null) return 1;
    if (cityIsLeaf) return 1;
    return 2;
  }

  bool get cityIsLeaf => _cityIsLeaf;

  String? get selectedRegionText {
    final p = province.value;
    final c = city.value;
    final a = area.value;
    if (p == null || c == null) return null;

    if (a == null || a.id == c.id) {
      // city 本身就是最终的区/县级市
      return '${p.name}${c.name}';
    }
    return '${p.name}${c.name}${a.name}';
  }

  void onTapBack() {
    if (province.value == null) {
      closePage();
      return;
    }

    if (city.value != null) {
      // 已选到区/县级市
      if (area.value != null) {
        area.value = null;
        // 回到“市”选择层
        final next = (_childrenByPid[province.value!.id] ??
                const <_AreaNode>[])
            .where((n) => n.name.isNotEmpty)
            .where((n) => _isDistrictOrCountyCity(n) || _hasLeafChild(n))
            .toList(growable: false);
        city.value = null;
        _setOptions(next);
        return;
      }

      // 只选了市（非 leaf）
      city.value = null;
      final next = (_childrenByPid[province.value!.id] ??
              const <_AreaNode>[])
          .where((n) => n.name.isNotEmpty)
          .where((n) => _isDistrictOrCountyCity(n) || _hasLeafChild(n))
          .toList(growable: false);
      _setOptions(next);
      return;
    }

    // 只选了省
    province.value = null;
    city.value = null;
    area.value = null;
    _setOptions(_provinceList);
  }

  void onTapComplete() {
    final text = selectedRegionText;
    if (text == null) return;
    Get.back(result: text);
  }
}