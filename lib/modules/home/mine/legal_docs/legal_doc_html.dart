String docTextToSemanticHtml({
  required String raw,
  required String title,
}) {
  // 1) 基础清洗：修复多余空白/制表
  var text = raw
      .replaceAll(RegExp(r'--\s*\d+\s*of\s*\d+\s*--'), '')
      .replaceAll('\t', ' ')
      .replaceAll(RegExp(r'[ \u00A0]{2,}'), ' ')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();

  // 2) 兼容少量“分字”噪声（PDF 抽取常见；docx 也可复用）
  text = text.replaceAll(RegExp(r'K\s*e\s*l\s*l\s*y\s*C\s*h\s*a\s*t'), 'KellyChat');
  text = text.replaceAll(RegExp(r'K\s*e\s*l+l+y\s*C\s*h\s*a\s*t'), 'KellyChat');

  // 3) 按行切分并做简单语义化
  final lines = text
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  // raw 首行往往就是标题，避免重复渲染
  final normalizedTitle = title.trim();
  if (lines.isNotEmpty && lines.first == normalizedTitle) {
    lines.removeAt(0);
  }

  final b = StringBuffer();
  b.writeln('<!doctype html>');
  b.writeln('<html><head><meta charset="utf-8"/>');
  b.writeln('<meta name="viewport" content="width=device-width, initial-scale=1"/>');
  b.writeln(r'''
<style>
:root{--fg:#111;--muted:#666;--border:#eee;--bg:#fff;--accent:#18A058;}
body{margin:0;background:var(--bg);color:var(--fg);font-family:-apple-system,BlinkMacSystemFont,"PingFang SC","Microsoft YaHei",Segoe UI,Roboto,Helvetica,Arial,sans-serif;}
.doc{max-width:860px;margin:0 auto;padding:20px 18px 40px;}
h1{font-size:20px;line-height:1.3;margin:0 0 10px;}
h2{font-size:17px;line-height:1.35;margin:18px 0 8px;padding-top:12px;border-top:1px solid var(--border);}
h3{font-size:15px;line-height:1.35;margin:14px 0 6px;}
p{font-size:14px;line-height:1.75;margin:8px 0;word-break:break-word;}
.meta{color:var(--muted);font-size:12px;line-height:1.6;margin:0 0 14px;}
.note{background:#f7f7f7;border:1px solid var(--border);border-radius:10px;padding:12px 12px;margin:12px 0;}
ul{margin:8px 0 8px 18px;padding:0;}
li{font-size:14px;line-height:1.75;margin:6px 0;}
hr{border:none;border-top:1px solid var(--border);margin:14px 0;}
</style>
''');
  b.writeln('</head><body><article class="doc">');

  b.writeln('<h1>${_esc(normalizedTitle)}</h1>');

  bool inList = false;
  void closeList() {
    if (inList) {
      b.writeln('</ul>');
      inList = false;
    }
  }

  for (final line in lines) {
    // 章节/条款标题
    if (RegExp(r'^第[一二三四五六七八九十百千]+章').hasMatch(line) ||
        RegExp(r'^[一二三四五六七八九十]+、').hasMatch(line)) {
      closeList();
      b.writeln('<h2>${_esc(line)}</h2>');
      continue;
    }
    if (RegExp(r'^第[一二三四五六七八九十百千]+条').hasMatch(line)) {
      closeList();
      b.writeln('<h3>${_esc(line)}</h3>');
      continue;
    }
    if (RegExp(r'^【.+】$').hasMatch(line)) {
      closeList();
      b.writeln('<div class="note"><p><strong>${_esc(line)}</strong></p></div>');
      continue;
    }

    // （一）（二）… 列表
    if (RegExp(r'^（[一二三四五六七八九十]+）').hasMatch(line)) {
      if (!inList) {
        b.writeln('<ul>');
        inList = true;
      }
      b.writeln('<li>${_esc(line)}</li>');
      continue;
    }

    // 1.1 / 2.3 等小节：当段落处理但加粗编号
    final m = RegExp(r'^(\d+(\.\d+)+)\s*(.+)$').firstMatch(line);
    if (m != null) {
      closeList();
      b.writeln('<p><strong>${_esc(m.group(1)!)}</strong> ${_esc(m.group(3)!)}</p>');
      continue;
    }

    closeList();
    b.writeln('<p>${_esc(line)}</p>');
  }

  closeList();
  b.writeln('</article></body></html>');
  return b.toString();
}

String _esc(String s) => s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');

