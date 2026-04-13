/// 省市区选择器初始滚动位置（与 [RegionPickerSheet] 索引对应）
class EditRegionIndices {
  EditRegionIndices({
    required this.provinceIndex,
    required this.cityIndex,
    this.districtIndex,
  });

  final int provinceIndex;
  final int cityIndex;
  final int? districtIndex;
}
