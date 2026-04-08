// 将 modood pca 转为 [{name,cities:[{name,districts}]}]，并追加港澳台
// 运行：dart run tool/gen_china_regions.dart
import 'dart:convert';
import 'dart:io';

void main() {
  final modoodPath = File('assets/data/china_admin_divisions_modood.json');
  final map = jsonDecode(modoodPath.readAsStringSync()) as Map<String, dynamic>;
  final list = <Map<String, dynamic>>[];

  // 保持 modood 源文件中的省级、地级顺序（与统计用区划代码发布顺序一致）
  for (final e in map.entries) {
    final p = e.key;
    final cVal = e.value;
    if (cVal is! Map<String, dynamic>) continue;
    final cities = <Map<String, dynamic>>[];
    for (final ce in cVal.entries) {
      final c = ce.key;
      final dVal = ce.value;
      if (dVal is! List) continue;
      cities.add({
        'name': c,
        'districts': dVal.map((e) => '$e').toList(),
      });
    }
    list.add({'name': p, 'cities': cities});
  }

  list.addAll(_hkMacauTaiwan());

  File('assets/data/china_regions.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(list),
  );
  stdout.writeln('Wrote assets/data/china_regions.json (${list.length} provinces)');
}

List<Map<String, dynamic>> _hkMacauTaiwan() {
  return [
    {
      'name': '香港特别行政区',
      'cities': [
        {
          'name': '香港',
          'districts': [
            '中西区',
            '湾仔区',
            '东区',
            '南区',
            '油尖旺区',
            '深水埗区',
            '九龙城区',
            '黄大仙区',
            '观塘区',
            '荃湾区',
            '屯门区',
            '元朗区',
            '北区',
            '大埔区',
            '西贡区',
            '沙田区',
            '葵青区',
            '离岛区',
          ],
        },
      ],
    },
    {
      'name': '澳门特别行政区',
      'cities': [
        {
          'name': '澳门',
          'districts': [
            '花地玛堂区',
            '圣安多尼堂区',
            '大堂区',
            '望德堂区',
            '风顺堂区',
            '嘉模堂区',
            '圣方济各堂区',
            '路氹填海区',
          ],
        },
      ],
    },
    {
      'name': '台湾省',
      'cities': [
        {
          'name': '台北市',
          'districts': [
            '中正区',
            '大同区',
            '中山区',
            '松山区',
            '大安区',
            '万华区',
            '信义区',
            '士林区',
            '北投区',
            '内湖区',
            '南港区',
            '文山区',
          ],
        },
        {
          'name': '新北市',
          'districts': [
            '板桥区',
            '三重区',
            '中和区',
            '永和区',
            '新庄区',
            '新店区',
            '树林区',
            '莺歌区',
            '三峡区',
            '淡水区',
            '汐止区',
            '瑞芳区',
            '土城区',
            '芦洲区',
            '五股区',
            '泰山区',
            '林口区',
            '深坑区',
            '石碇区',
            '坪林区',
            '三芝区',
            '石门区',
            '八里区',
            '平溪区',
            '双溪区',
            '贡寮区',
            '金山区',
            '万里区',
            '乌来区',
          ],
        },
        {
          'name': '桃园市',
          'districts': [
            '桃园区',
            '中坜区',
            '平镇区',
            '八德区',
            '杨梅区',
            '芦竹区',
            '大溪区',
            '龙潭区',
            '龟山区',
            '大园区',
            '观音区',
            '新屋区',
            '复兴区',
          ],
        },
        {
          'name': '台中市',
          'districts': [
            '中区',
            '东区',
            '南区',
            '西区',
            '北区',
            '西屯区',
            '南屯区',
            '北屯区',
            '丰原区',
            '东势区',
            '大甲区',
            '清水区',
            '沙鹿区',
            '梧栖区',
            '后里区',
            '神冈区',
            '潭子区',
            '大雅区',
            '新社区',
            '石冈区',
            '外埔区',
            '大安区',
            '乌日区',
            '大肚区',
            '龙井区',
            '雾峰区',
            '太平区',
            '和平区',
          ],
        },
        {
          'name': '台南市',
          'districts': [
            '中西区',
            '东区',
            '南区',
            '北区',
            '安平区',
            '安南区',
            '永康区',
            '归仁区',
            '新化区',
            '左镇区',
            '玉井区',
            '楠西区',
            '南化区',
            '仁德区',
            '关庙区',
            '龙崎区',
            '官田区',
            '麻豆区',
            '佳里区',
            '西港区',
            '七股区',
            '将军区',
            '学甲区',
            '北门区',
            '新营区',
            '后壁区',
            '白河区',
            '东山区',
            '六甲区',
            '下营区',
            '柳营区',
            '盐水区',
            '善化区',
            '大内区',
            '山上区',
            '新市区',
            '安定区',
          ],
        },
        {
          'name': '高雄市',
          'districts': [
            '新兴区',
            '前金区',
            '苓雅区',
            '盐埕区',
            '鼓山区',
            '旗津区',
            '前镇区',
            '三民区',
            '楠梓区',
            '小港区',
            '左营区',
            '仁武区',
            '大社区',
            '冈山区',
            '路竹区',
            '阿莲区',
            '田寮区',
            '燕巢区',
            '桥头区',
            '梓官区',
            '弥陀区',
            '永安区',
            '湖内区',
            '凤山区',
            '大寮区',
            '林园区',
            '鸟松区',
            '大树区',
            '旗山区',
            '美浓区',
            '六龟区',
            '内门区',
            '杉林区',
            '甲仙区',
            '桃源区',
            '那玛夏区',
            '茂林区',
            '茄萣区',
          ],
        },
        {
          'name': '基隆市',
          'districts': ['仁爱区', '信义区', '中正区', '中山区', '安乐区', '暖暖区', '七堵区'],
        },
        {
          'name': '新竹市',
          'districts': ['东区', '北区', '香山区'],
        },
        {
          'name': '嘉义市',
          'districts': ['东区', '西区'],
        },
      ],
    },
  ];
}
