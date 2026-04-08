import 'package:flutter/material.dart';
import 'package:youth/utils/utils/theme_color.dart';
import 'region_picker_data.dart';

/// 当前选中的省 / 市 / 区（仅展示用快照）
class RegionPickerSelection {
  const RegionPickerSelection({
    required this.province,
    required this.city,
    required this.district,
  });

  final String province;
  final String city;
  final String district;
}

/// 省市区底部选择面板（纯 UI，数据由 [provinces] 传入）
///
/// 使用示例：
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   backgroundColor: Colors.transparent,
///   isScrollControlled: true,
///   builder: (ctx) => RegionPickerSheet(
///     provinces: list,
///     onClose: () => Navigator.pop(ctx),
///     onSelectionChanged: (s) { },
///   ),
/// );
/// ```
class RegionPickerSheet extends StatefulWidget {
  const RegionPickerSheet({
    super.key,
    required this.provinces,
    this.title = '设置地区',
    this.initialProvinceIndex = 0,
    this.initialCityIndex = 0,
    this.initialDistrictIndex,
    this.initialTabIndex = 0,
    required this.onClose,
    this.onSelectionChanged,
  });

  final List<RegionProvince> provinces;
  final String title;
  final int initialProvinceIndex;
  final int initialCityIndex;
  /// 为 `null` 时不预选任何区，需用户手动点选
  final int? initialDistrictIndex;
  /// 0 省 / 1 市 / 2 区，与设计稿一致可传 2
  final int initialTabIndex;
  final VoidCallback onClose;
  final void Function(RegionPickerSelection selection)? onSelectionChanged;

  static const Color _accent = ThemeColor.themeGreenColor;
  static const Color _tabBarBg = Color(0xFF1F1F1F);
  static const Color _listBg = Color(0xFF171717);

  @override
  State<RegionPickerSheet> createState() => _RegionPickerSheetState();
}

class _RegionPickerSheetState extends State<RegionPickerSheet> {
  late int _tabIndex;
  late int _provinceIndex;
  late int _cityIndex;
  /// `null` 表示尚未选择区，列表不显示勾选
  int? _districtIndex;

  @override
  void initState() {
    super.initState();
    _provinceIndex =
        _clamp(widget.initialProvinceIndex, 0, _maxProvince);
    _cityIndex = _clamp(widget.initialCityIndex, 0, _maxCity);
    final di = widget.initialDistrictIndex;
    if (di != null && di >= 0 && di <= _maxDistrict) {
      _districtIndex = di;
    } else {
      _districtIndex = null;
    }
    _tabIndex = widget.initialTabIndex.clamp(0, 2);
    _notifySelection();
  }

  int get _maxProvince =>
      widget.provinces.isEmpty ? 0 : widget.provinces.length - 1;

  int get _maxCity {
    if (widget.provinces.isEmpty) return 0;
    final cities = widget.provinces[_provinceIndex].cities;
    return cities.isEmpty ? 0 : cities.length - 1;
  }

  int get _maxDistrict {
    if (widget.provinces.isEmpty) return 0;
    final cities = widget.provinces[_provinceIndex].cities;
    if (cities.isEmpty) return 0;
    final ds = cities[_cityIndex].districts;
    return ds.isEmpty ? 0 : ds.length - 1;
  }

  void _syncCityIndexAfterProvince() {
    _cityIndex = _clamp(_cityIndex, 0, _maxCity);
  }

  void _syncDistrictIndexAfterCity() {
    if (_districtIndex == null) return;
    if (_maxDistrict < 0) {
      _districtIndex = null;
      return;
    }
    _districtIndex = _clamp(_districtIndex!, 0, _maxDistrict);
  }

  int _clamp(int v, int min, int max) {
    if (max < min) return min;
    if (v < min) return min;
    if (v > max) return max;
    return v;
  }

  RegionPickerSelection get _selection {
    if (widget.provinces.isEmpty) {
      return const RegionPickerSelection(
        province: '',
        city: '',
        district: '',
      );
    }
    final p = widget.provinces[_provinceIndex];
    final cities = p.cities;
    if (cities.isEmpty) {
      return RegionPickerSelection(
        province: p.name,
        city: '',
        district: '',
      );
    }
    final c = cities[_cityIndex];
    final ds = c.districts;
    final di = _districtIndex;
    final d = (di == null || di < 0 || di >= ds.length) ? '' : ds[di];
    return RegionPickerSelection(
      province: p.name,
      city: c.name,
      district: d,
    );
  }

  void _notifySelection() {
    widget.onSelectionChanged?.call(_selection);
  }

  void _setTab(int i) {
    setState(() => _tabIndex = i.clamp(0, 2));
  }

  void _selectProvince(int index) {
    setState(() {
      _provinceIndex = index;
      _syncCityIndexAfterProvince();
      _districtIndex = null;
      _syncDistrictIndexAfterCity();
      _tabIndex = 1;
    });
    _notifySelection();
  }

  void _selectCity(int index) {
    setState(() {
      _cityIndex = index;
      _districtIndex = null;
      _syncDistrictIndexAfterCity();
      _tabIndex = 2;
    });
    _notifySelection();
  }

  void _selectDistrict(int index) {
    setState(() => _districtIndex = index);
    _notifySelection();
  }

  List<String> _currentOptions() {
    if (widget.provinces.isEmpty) return [];
    switch (_tabIndex) {
      case 0:
        return widget.provinces.map((e) => e.name).toList();
      case 1:
        return widget.provinces[_provinceIndex].cities.map((e) => e.name).toList();
      case 2:
        return widget.provinces[_provinceIndex].cities[_cityIndex].districts;
      default:
        return [];
    }
  }

  bool _isItemChecked(int index) {
    switch (_tabIndex) {
      case 0:
        return index == _provinceIndex;
      case 1:
        return index == _cityIndex;
      case 2:
        return _districtIndex != null && index == _districtIndex;
      default:
        return false;
    }
  }

  void _onTapItem(int index) {
    switch (_tabIndex) {
      case 0:
        _selectProvince(index);
        break;
      case 1:
        _selectCity(index);
        break;
      case 2:
        _selectDistrict(index);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final options = _currentOptions();

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(
                title: widget.title,
                onClose: widget.onClose,
              ),
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      color: RegionPickerSheet._tabBarBg,
                      child: _TabBar(
                        selection: _selection,
                        tabIndex: _tabIndex,
                        onTab: _setTab,
                        accent: RegionPickerSheet._accent,
                      ),
                    ),
                    Container(
                      height: 320,
                      width: double.infinity,
                      color: RegionPickerSheet._listBg,
                      child: options.isEmpty
                          ? const Center(
                              child: Text(
                                '暂无数据',
                                style: TextStyle(
                                  color: Color(0xFF8E8E93),
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(bottom: bottom + 8),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final label = options[index];
                                final checked = _isItemChecked(index);
                                return _RegionListTile(
                                  label: label,
                                  checked: checked,
                                  accent: RegionPickerSheet._accent,
                                  onTap: () => _onTapItem(index),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white, size: 22),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.selection,
    required this.tabIndex,
    required this.onTab,
    required this.accent,
  });

  final RegionPickerSelection selection;
  final int tabIndex;
  final void Function(int) onTab;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabCell(
          label: selection.province.isEmpty ? '省' : selection.province,
          active: tabIndex == 0,
          accent: accent,
          onTap: () => onTab(0),
        ),
        _TabCell(
          label: selection.city.isEmpty ? '市' : selection.city,
          active: tabIndex == 1,
          accent: accent,
          onTap: () => onTab(1),
        ),
        _TabCell(
          label: selection.district.isEmpty ? '区' : selection.district,
          active: tabIndex == 2,
          accent: accent,
          onTap: () => onTab(2),
        ),
      ],
    );
  }
}

class _TabCell extends StatelessWidget {
  const _TabCell({
    required this.label,
    required this.active,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.92),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: active ? accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionListTile extends StatelessWidget {
  const _RegionListTile({
    required this.label,
    required this.checked,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool checked;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: checked
                  ? Icon(Icons.check_rounded, color: accent, size: 22)
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
