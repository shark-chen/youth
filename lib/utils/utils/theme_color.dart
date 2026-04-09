import 'package:flutter/material.dart';

/// FileName theme_color
///
/// @Author 谌文
/// @Date 2025/2/5 20:26
///
/// @Description 主题颜色
class ThemeColor {
  static ButtonStyle noPaddingButtonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: MaterialStateProperty.all(const Size(0, 0)),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
  );

  static TextStyle white16Text =
      const TextStyle(color: Colors.white, fontSize: 16);

  static TextStyle white18Text =
      const TextStyle(color: Colors.white, fontSize: 18);
  static TextStyle white14Text =
      const TextStyle(color: Colors.white, fontSize: 14);
  static TextStyle black16Text =
      const TextStyle(color: Colors.black87, fontSize: 16);

  static TextStyle black12Text =
      const TextStyle(color: Colors.black87, fontSize: 13);

  static TextStyle black14Text =
      const TextStyle(color: Colors.black87, fontSize: 14);

  static TextStyle black18Text =
      const TextStyle(color: Colors.black87, fontSize: 18);

  static TextStyle titleBlackTextStyle = TextStyle(
      color: ThemeColor.titleBlack, fontSize: 18, fontWeight: FontWeight.w600);
  static TextStyle defaultBlackTextStyle =
      TextStyle(color: ThemeColor.defaultBlack, fontSize: 14);

  static TextStyle otherBlackTextStyle =
      const TextStyle(color: ThemeColor.otherBlack, fontSize: 14);
  static TextStyle loginOutTextStyle =
      const TextStyle(color: Color.fromRGBO(229, 46, 0, 1), fontSize: 14);
  static TextStyle aboutTextStyle = const TextStyle(
      color: Color.fromRGBO(97, 96, 102, 1),
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static TextStyle dangerStyle = TextStyle(
      color: Colors.red.shade300, fontSize: 14, fontWeight: FontWeight.w400);
  static Color defaultBlack = const Color.fromRGBO(49, 48, 51, 1);
  static Color titleBlack = const Color.fromRGBO(48, 51, 54, 1);
  static const Color otherBlack = Color(0xFF333333);
  static Color personalBackColor = const Color.fromRGBO(245, 246, 248, 1);
  static Color whiteColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color redColor = const Color.fromRGBO(255, 71, 71, 1);
  static BorderRadius borderRadius10 =
      const BorderRadius.all(Radius.circular(10));
  static const Color bgGrayColor = Color(0xFFF5F6F8);
  static const Color blueBtnColor = Color(0xFF4934B2);
  static const Color lackLineColor = Color(0xFFF2F2F2);
  static OutlineInputBorder textInputBorder =
      OutlineInputBorder(borderRadius: borderRadius10);
  static Color defaultColor = const Color.fromRGBO(73, 52, 178, 1);
  static Color trailingColor = const Color.fromRGBO(188, 188, 188, 1);
  static Color versionColor = const Color.fromRGBO(145, 144, 153, 1);
  static Color greyColor = const Color.fromRGBO(107, 104, 96, 1);
  static Color tipsColor = const Color.fromRGBO(235, 237, 241, 1);
  static const Color blueColor = Color(0xFF4635AB);
  static const Color mainTextColor = Color(0xFF313033);
  static const Color secondaryTextColor = Color(0xFF919099);
  static const Color secondTextColor = Color(0xFF919098);
  static const Color otherTextColor = Color(0xFF616066);
  static const Color greenColor = Color(0xFF52B590);
  static const Color pitchBlackColor = Color(0xFF303336);
  static const Color lightGrayColor = Color(0xFFA0A3A6);
  static const Color thickBlackColor = Color(0xFF313033);
  static const Color darkBlueColor = Color(0xFF4934B2);
  static const Color thinGrayColor = Color(0xFFF5F6F8);
  static const Color brightRedColor = Color(0xFFFF4747);
  static const Color lineColor = Color(0xFFF2F2F2);
  static const Color excrementYellowColor = Color(0xFFF1A252);
  static const Color blurryBlackColor = Color(0xFFEBEBEB);
  static const Color gradeFiveGreyColor = Color(0xFFE5E5E5);
  static const Color bringShameColor = Color(0xFF040616);
  static const Color snowyWhiteColor = Color(0xFFF5F6F8);
  static const Color ayzColor = Color(0xFFBCBCBC);
  static const Color mainBlueColor = Color(0xFF156DEC);
  static const Color lightGray2Color = Color(0xFF8E98A4);
  static const Color bgGray2Color = Color(0xFFF6F6F6);
  static const Color errorRedColor = Color(0xFFFFE5E5);
  static const Color lightPurpleColor = Color(0xFFEEEBF9);
  static const Color shadowGrayColor = Color(0x12000000);
  static const Color shadowPurpleStartColor = Color(0xFFD2DAFF);
  static const Color shadowPurpleEndColor = Color(0xFFF1F3FF);
  static const Color shadowVioletStartColor = Color(0xFFD2DAFF);
  static const Color shadowVioletEndColor = Color(0xFFF1F3FF);
  static const Color shadowBlueStartColor = Color(0xFFB8DAFF);
  static const Color shadowBlueEndColor = Color(0xFFE4F1FF);
  static const Color shadowGreenStartColor = Color(0xFF9EE6D7);
  static const Color shadowGreenEndColor = Color(0xFFDEFEF7);
  static const Color graynessBgColor = Color(0xFFF2F3F5);
  static const Color blueBgColor = Color(0xFFE5F0FF);
  static const Color threeDColor = Color(0xFFDDDDDD);
  static const Color threeBColor = Color(0xFFBBBBBB);
  static const Color lightGreyBgColor = Color(0xFFF0F0F0);
  static const Color nattierBlueColor = Color(0xFF0C6DFF);
  static const Color skyBlueColor = Color(0xFFE5F0FF);
  static const Color backgroundBlueColor = Color(0xFFE6F7FF);
  static const Color titleBlueColor = Color(0xFF52AFFF);
  static const Color line3DColor = Color(0xFFDDDDDD);
  static const Color loginFormBackColor = Color(0xFFF2F3F5);
  static const Color loginFormTextColor = Color(0xFF919099);
  static const Color checkBoxBorderColor = Color(0xFFDDDDDD);
  static const Color hallSalesStartColor = Color(0xFFC6D1FF);
  static const Color hallSalesEndColor = Color(0xFFEBEEFF);
  static const Color gingerColor = Color(0xFFFFF7E5);
  static const Color deepGingerColor = Color(0xFFC7711C);
  static const Color extraLightGreyColor = Color(0xFFEFF0F2);
  static const Color cambridgeBlueColor = Color(0xFFACA3DC);
  static const Color paleGreenColor = Color(0xFFD9EFEB);
  static const Color arrowGrayColor = Color(0xFFD6D6D6);
  static const Color lightRedColor = Color(0xFFFFECEC);
  static const Color borderGrayColor = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE5E6EB);
  static const Color threeF5Color = Color(0xFFF5F5F5);
  static const Color deepPurpleColor = Color(0xFF65789B);
  static const Color lavenderColor = Color(0xFFF2F0FE);
  static const Color lightShitColor = Color(0xFFFFF5E9);
  static const Color blueGreenColor = Color(0xFFE0F7ED);
  static const Color turquoiseColor = Color(0xFFE6F4FF);
  static const Color transparentBlackColor = Color(0x92000000);
  static const Color buttonGrayColor = Color(0xFFE4E6EB);
  static const Color greenCapColor = Color(0xFF009174);
  static const Color greenStatusColor = Color(0xFFD9F7EB);
  static const Color orangeColor = Color(0xFFFF9C00);
  static const Color lightGreenColor = Color(0xFF34C759);
  static const Color textGrayColor = Color(0xFF616065);
  static const Color threeLineColor = Color(0xFFA1A3A6);
  static const Color greyBlackColor = Color(0xFF232526);
  static const Color lineBlueColor = Color(0xFF4635AB);
  static const Color graynessColor = Color(0xFF616065);
  static const Color gradientGrayStartColor = Color(0xFFDDE0E4);
  static const Color gradientGrayEndColor = Color(0xFFF5F6F8);
  static const Color btnTitleRedColor = Color(0xFFEB564F);
  static const Color lineRedColor = Color(0xFFF3B1AF);
  static const Color violetLineColor = Color(0xFFBCADF1);
  static const Color bloodRedColor = Color(0xFFFF3B30);
  static const Color threeD2Color = Color(0xFFD2D2D2);
  static const Color brightGreenColor = Color(0xFF00B88D);
  static const Color darkGreenColor = Color(0xFF006B59);
  static const Color greenBlueColor = Color(0xFF9BE9CF);
  static const Color lineYellowColor = Color(0xFFF8D8A8);
  static const Color grayGreenBlueColor = Color(0xFFB2A4FF);
  static const Color threeFAColor = Color(0xFFFAFAFA);
  static const Color dashedLineColor = Color(0xFFE0E6F1);
  static const Color deepBlueColor = Color(0xFF004FD9);
  static const Color bluerColor = Color(0xFFF2F0FF);
  static const Color treeBlueColor = Color(0xFF4131A0);
  static const Color paleRedColor = Color(0xFFFBE6E5);
  static const Color orangeYellowColor = Color(0xFFF1A139);
  static const Color pickGreenColor = Color(0xFF65C466);
  static const Color urineYellowColor = Color(0xFFFF9E3D);
  static const Color appleRedColor = Color(0xFFE52E00);
  static const Color disableColor = Color(0xFFBBBABF);
  static const Color markBlueColor = Color(0xFF8F7AE0);
  static const Color markBgBlueColor = Color(0xFFDBD0FB);
  static const Color markBgGrayColor = Color(0xFFE8EAED);
  static const Color blackColor = Color(0xFF000000);
  static const Color orangeRedColor = Color(0xFF28713E);
  static const Color dyingEmbersColor = Color(0xFFDD7907);
  static const Color eightyZeroColor = Color(0xFF808080);
  static const Color lineBroderColor = Color(0xFFDFDFE2);
  static const Color labelBlueColor = Color(0xFFB0DAFF);
  static const Color labelVioletColor = Color(0xFFE7DFFF);
  static const Color labelOrangeColor = Color(0xFFFFE6C2);
  static const Color labelOrangeBroderColor = Color(0xFFFFFAF0);
  static const Color labelGreenColor = Color(0xFFCFF2E3);
  static const Color labelGreenBroderColor = Color(0xFFEFFAF8);
  static const Color bgRedColor = Color(0xFFFDF2F0);
  static const Color broderBlueColor = Color(0xFFE7E6EB);
  static const Color waveBlueBgColor = Color(0xFFF3F4F6);
  static const Color contentRedColor = Color(0xFFDB5341);
  static const Color biLuColor = Color(0xFF86909C);
  static const Color babyBlueColor = Color(0xFFEEF0FF);
  static const Color soBlackColor = Color(0xFF1D2129);
  static const Color borderBlueColor = Color(0xFF6046E5);
  static const Color buttonDisableColor = Color(0xFFC7CCFE);
  static const Color bananaYellowColor = Color(0xFFFFF3C5);
  static const Color appleBlueColor = Color(0xFF1472FF);
  static const Color appleShallowBlueColor = Color(0xFF8EC5FF);
  static const Color successBgColor = Color(0xFFDFF7ED);
  static const Color errorBgColor = Color(0xFFFFF0ED);
  static const Color yellowBgColor = Color(0xFFFFF3C5);
  static const Color yellowFontColor = Color(0xFFB84C00);
  static const Color twoTextColor = Color(0xFF4E5969);

  static const Color themeColor = Color(0xFF171717);
  static const Color inputBgColor = Color(0xFF232323);
  /// 深色列表卡片（如「正在」同频用户 cell）
  static const Color doingListCellBgColor = Color(0xFF2C2C2E);
  /// 深色次级文案（年龄·城市等）
  static const Color doingListSubLabelColor = Color(0xFFAEAEB2);
  /// 深色简介/辅助一行
  static const Color doingListBioLabelColor = Color(0xFF636366);
  /// 「敲一下」等深绿底按钮
  static const Color doingListKnockBgColor = Color(0xFF1A3D2E);
  /// 「一起做」等次级胶囊按钮底
  static const Color doingListTogetherBgColor = Color(0xFF3A3A3C);
  static const Color themeGreenColor = Color(0xFF10FF93);
  static const Color themeBlackColor = Color(0xFF030303);
  static const Color themeA2Color = Color(0xFFA2A2A2);
  static const Color poolBlueColor = Color(0xFFE1F7FF);
  static const Color textBlackColor = Color(0xFF050503);
  static const Color iconBlackColor = Color(0xFF727272);
  static const Color theme5FColor = Color(0xFF5F5F5F);
  static const Color pinkColor = Color(0xFFFFE1E1);
  static const Color cardBgColor = Color(0xFF292929);
  static const Color themeFourZeroColor = Color(0xFF292929);
  static const Color theme7FColor = Color(0xFF7F7F7F);
  static const Color violetColor = Color(0xFFBA66FF);
  static Color white6Color = Color(0xFFFFFFFF)..withOpacity(0.6);
}
