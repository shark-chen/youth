/// FileName invitation_code_utils
///
/// @Description 邀请口令校验工具
class InvitationCodeUtils {
  InvitationCodeUtils._();

  /// 邀请口令：数字+字母组合，长度恰好 9 位（如 24A76861A）
  static final RegExp _pattern =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9]{9}$');

  /// 是否为有效邀请口令
  static bool isInvitationCode(String content) =>
      _pattern.hasMatch(content.trim());

  /// 规范化邀请口令（去空格）；非法则返回 null
  static String? normalizeInvitationCode(String content) {
    final trimmed = content.trim();
    return isInvitationCode(trimmed) ? trimmed : null;
  }
}
