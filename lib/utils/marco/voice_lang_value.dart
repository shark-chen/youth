///后端语音播报多语言简码值
enum VoiceLangValue {
  ///中文
  zh('zh_CN'),
  ///印尼语
  id('in_ID'),
  ///越南语
  vi('vi_VN'),
  ///泰语
  th('th_TH'),
  ///缅甸语
  md('md_MD'),
  ///柬埔寨语
  jpz('jpz-JPZ'),
  ///英语
  en('en_US');

  const VoiceLangValue(this.value);

  final String value;
}
