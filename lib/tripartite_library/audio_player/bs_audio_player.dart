import 'package:youth/base/base_controller.dart';
import 'package:just_audio/just_audio.dart';

/// FileName bs_audio_player
///
/// @Author 谌文
/// @Date 2023/11/20 11:34
///
/// @Description 语音播报器
class BSAudioPlayer {
  static final BSAudioPlayer _instance = BSAudioPlayer._internal();
  final AudioPlayer audioPlayer = AudioPlayer();

  BSAudioPlayer._internal();

  factory BSAudioPlayer() {
    return _instance;
  }

  /// 语音播报
  final player = AudioPlayer();

  /// 播报扫描
  Future playScan() async {
    try {
      await player.stop();
      await player.setAsset("assets/sound/scan_one1.wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报扫描失败
  Future playScanError() async {
    try {
      await player.stop();
      await player.setAsset("assets/sound/error1.wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报扫描成功
  Future playScanSuccess() async {
    try {
      await player.stop();
      await player.setAsset("assets/sound/success.wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报扫描发货提示音
  Future playScanShipTips() async {
    try {
      await player.stop();
      await player.setAsset("assets/sound/voice_anno/scan_one.wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报扫描发货成功
  Future playScanShipVoiceAnnoSuccess(String? lang) async {
    if (Strings.isEmpty(lang)) {
      return;
    }
    try {
      await player.stop();
      await player
          .setAsset("assets/sound/voice_anno/success_" + lang! + ".wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报扫描发货失败
  Future playScanShipVoiceAnnoError(String? lang) async {
    if (Strings.isEmpty(lang)) {
      return;
    }
    try {
      await player.stop();
      await player.setAsset("assets/sound/voice_anno/error_" + lang! + ".wav");
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 物流语音播报链接
  Future playLogisticsVoiceAnno(String? url) async {
    if (Strings.isEmpty(url)) {
      return;
    }
    try {
      await player.stop();
      await player.setUrl(url!);
      await player.play();
    } catch (_) {
    } finally {}
  }

  /// 播报终止
  Future playStop() async {
    try {
      await player.stop();
    } catch (_) {
    } finally {}
  }
}
