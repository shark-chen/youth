import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kellychat/utils/utils/theme_color.dart';
import 'package:path_provider/path_provider.dart';

/// 全屏裁剪页（基于项目已有 [extended_image] 编辑器，无额外原生裁剪库）
Future<XFile?> openImageCropEditor(
  BuildContext context, {
  required String sourcePath,
  double? cropAspectRatio,
}) async {
  if (kIsWeb) return null;
  return Navigator.of(context).push<XFile?>(
    MaterialPageRoute<XFile?>(
      fullscreenDialog: true,
      builder: (ctx) => _ImageCropEditorPage(
        sourcePath: sourcePath,
        cropAspectRatio: cropAspectRatio,
      ),
    ),
  );
}

Future<Uint8List?> _exportCroppedPng(GlobalKey<ExtendedImageEditorState> key) async {
  final st = key.currentState;
  if (st == null) return null;
  final ui.Image? src = st.image;
  final Rect? crop = st.getCropRect();
  if (src == null || crop == null) return null;
  if (crop.width < 1 || crop.height < 1) return null;

  final w = crop.width.round().clamp(1, 4096);
  final h = crop.height.round().clamp(1, 4096);

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawImageRect(
    src,
    crop,
    Rect.fromLTWH(0, 0, crop.width, crop.height),
    Paint(),
  );
  final picture = recorder.endRecording();
  final ui.Image out = await picture.toImage(w, h);
  picture.dispose();

  final bd = await out.toByteData(format: ui.ImageByteFormat.png);
  out.dispose();
  if (bd == null) return null;
  return bd.buffer.asUint8List();
}

class _ImageCropEditorPage extends StatefulWidget {
  const _ImageCropEditorPage({
    required this.sourcePath,
    this.cropAspectRatio,
  });

  final String sourcePath;
  final double? cropAspectRatio;

  @override
  State<_ImageCropEditorPage> createState() => _ImageCropEditorPageState();
}

class _ImageCropEditorPageState extends State<_ImageCropEditorPage> {
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();
  bool _busy = false;

  Future<void> _onDone() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final bytes = await _exportCroppedPng(_editorKey);
      if (!mounted) return;
      if (bytes == null || bytes.isEmpty) {
        Navigator.of(context).pop(null);
        return;
      }
      final dir = await getTemporaryDirectory();
      final out = File(
        '${dir.path}/kelly_crop_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await out.writeAsBytes(bytes, flush: true);
      Navigator.of(context).pop(XFile(out.path));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.textBlackColor,
      appBar: AppBar(
        backgroundColor: ThemeColor.textBlackColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: ThemeColor.whiteColor.withOpacity(0.85)),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        title: Text(
          '编辑图片',
          style: TextStyle(
            color: ThemeColor.whiteColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _busy ? null : _onDone,
            child: _busy
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ThemeColor.themeGreenColor,
                    ),
                  )
                : Text(
                    '完成',
                    style: TextStyle(
                      color: ThemeColor.themeGreenColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ExtendedImage.file(
          File(widget.sourcePath),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          extendedImageEditorKey: _editorKey,
          enableLoadState: true,
          initEditorConfigHandler: (_) => EditorConfig(
            cropAspectRatio: widget.cropAspectRatio,
            initialCropAspectRatio: widget.cropAspectRatio,
            cropRectPadding: const EdgeInsets.all(16),
            cornerColor: ThemeColor.themeGreenColor,
            lineColor: ThemeColor.whiteColor.withOpacity(0.85),
          ),
        ),
      ),
    );
  }
}
