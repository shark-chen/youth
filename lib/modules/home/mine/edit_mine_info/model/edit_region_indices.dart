/// 省市区选择器初始滚动位置（与 [RegionPickerSheet] 索引对应）
class EditRegionIndices {
  EditRegionIndices({
    required this.provinceIndex,
    required this.cityIndex,
    this.districtIndex,
    this.initialTabIndex = 0,
  });

  final int provinceIndex;
  final int cityIndex;
  final int? districtIndex;

  /// 打开时默认展示的 Tab：0 省 / 1 市 / 2 区
  final int initialTabIndex;
}
