import 'package:flutter/material.dart';
import 'package:kellychat/base/base_controller.dart';
import 'package:kellychat/utils/utils.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
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
/// 须由父级在 [showModalBottomSheet] 中配合 [isScrollControlled] 与固定高度包一层，
/// 使本组件内 [Column] 获得有限高度，避免底部溢出。
class RegionPickerSheet extends StatefulWidget {
  const RegionPickerSheet({
    super.key,
    required this.provinces,
    this.title = '选择地区',
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
  final int? initialDistrictIndex;
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
  int? _districtIndex;

  @override
  void initState() {
    super.initState();
    _provinceIndex = _clamp(widget.initialProvinceIndex, 0, _maxProvince);
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
        return widget.provinces[_provinceIndex].cities
            .map((e) => e.name)
            .toList();
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
    final options = _currentOptions();
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: ThemeColor.textBlackColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              title: widget.title,
              onClose: widget.onClose,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: ThemeColor.three2EColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: _TabBar(
                selection: _selection,
                tabIndex: _tabIndex,
                onTab: _setTab,
                accent: RegionPickerSheet._accent,
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: bottomPadding),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColor.three2EColor,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                width: double.infinity,
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
                        padding: const EdgeInsets.only(bottom: 8),
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
            ),
          ],
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
      padding: const EdgeInsets.fromLTRB(20, 14, 8, 8),
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
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.85),
              size: 22,
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          children: [
            Visibility(
              visible: checked,
              child: SizedBox(
                width: 28,
                child: checked
                    ? Icon(Icons.check_rounded, color: accent, size: 22)
                    : const SizedBox.shrink(),
              ),
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
