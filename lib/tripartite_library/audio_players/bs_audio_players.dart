import 'package:audioplayers/audioplayers.dart';
import 'package:youth/utils/extension/strings/strings.dart';
import 'package:flutter/foundation.dart';

/// FileName: bs_audio_players
///
/// @Author 谌文
/// @Date 2025/9/15 13:30
///
/// @Description 语音播报器
class BSAudioPlayers {
  static final BSAudioPlayers _instance = BSAudioPlayers._internal();

  BSAudioPlayers._internal();

  factory BSAudioPlayers() {
    return _instance;
  }

  /// 语音播报
  final player = AudioPlayer();

  /// 播报扫描
  Future playScan() async {
    try {
      await player
          .play(AssetSource('sound/scan_one1.wav'))
          .timeout(Duration(microseconds: 2000));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报扫描失败
  Future playScanError() async {
    try {
      await player
          .play(AssetSource("sound/error1.wav"))
          .timeout(Duration(microseconds: 2000));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报扫描成功
  Future playScanSuccess() async {
    try {
      await player
          .play(AssetSource('sound/success.wav'))
          .timeout(Duration(microseconds: 2000));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报
  Future play(String fileName) async {
    try {
      await player.setSourceDeviceFile(fileName);
      await player.resume().timeout(Duration(seconds: 10));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报扫描发货提示音
  Future playScanShipTips() async {
    try {
      await player
          .play(AssetSource('sound/voice_anno/scan_one.wav'))
          .timeout(Duration(microseconds: 2000));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报扫描发货成功
  Future playScanShipVoiceAnnoSuccess(String? lang) async {
    if (Strings.isEmpty(lang)) {
      return;
    }
    try {
      await player
          .play(AssetSource("sound/voice_anno/success_" + lang! + ".wav"))
          .timeout(Duration(seconds: 6));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报扫描发货失败
  Future playScanShipVoiceAnnoError(String? lang) async {
    if (Strings.isEmpty(lang)) {
      return;
    }
    try {
      await player
          .play(AssetSource("sound/voice_anno/error_" + lang! + ".wav"))
          .timeout(Duration(seconds: 6));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 物流语音播报链接
  Future playLogisticsVoiceAnno(String? url) async {
    if (Strings.isEmpty(url)) {
      return;
    }
    try {
      await player.play(UrlSource(url!)).timeout(Duration(seconds: 6));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }

  /// 播报终止
  Future playStop() async {
    try {
      await player.stop().timeout(Duration(microseconds: 2000));
    } catch (e) {
      debugPrint('error $e');
    } finally {}
  }
}
