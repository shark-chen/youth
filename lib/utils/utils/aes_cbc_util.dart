import 'dart:typed_data';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';
import '../extension/strings/strings.dart';

class AesCbcUtil {
  static String encrypt(String plainText) {
    if(Strings.isEmpty(plainText)) return plainText;
    var key = Key.fromSecureRandom(16);
    final keyBytes = key.bytes;
    var iv = IV.fromSecureRandom(16);
    final ivBytes = iv.bytes;
    var pad = fillRandom(2);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    var bytes = encrypted.bytes;
    var resList =
        Uint8List(pad.length + keyBytes.length + ivBytes.length + bytes.length);
    int i = 0;
    for (var value in pad) {
      resList[i++] = value;
    }
    for (var value in ivBytes) {
      resList[i++] = value;
    }
    for (var value in keyBytes) {
      resList[i++] = value;
    }
    for (var value in bytes) {
      resList[i++] = value;
    }
    return "0${hex.encode(resList)}";
  }

  static Uint8List fillRandom(int len) {
    final secureRandom = Random.secure();
    final bytes = Uint8List(len);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = secureRandom.nextInt(256);
    }
    return bytes;
  }
}
