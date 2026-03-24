import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:image/image.dart';
import 'esc_pos_convert.dart';
export 'esc_pos_convert.dart';

/// FileName: esc_pos_utils
///
/// @Author 谌文
/// @Date 2025/9/19 14:59
///
/// @Description POS指令打印面单
/// POS指令工具类
class EscPosUtils {
  static EscPosUtils? _instance;

  factory EscPosUtils(EscPaperSize pagerSize, {int spaceBetweenRows = 5}) {
    _instance ??= EscPosUtils._(pagerSize, spaceBetweenRows: spaceBetweenRows);
    return _instance!;
  }

  EscPosUtils._(this.pagerSize, {this.spaceBetweenRows = 5});

  /// 小票大小
  EscPaperSize pagerSize;
  int spaceBetweenRows;

  /// 小票构造器
  late Generator generator;

  /// 引擎- 不可以反复去加载，所以此类就搞成单利类了
  CapabilityProfile? _profile;
  bool _isProfileLoaded = false;

  /// 生成小票构造器
  /// 生成小票构造器
  Future<Generator?> createGenerator() async {
    /// 根据 pagerSize 设置纸张尺寸
    var paperSize;
    switch (pagerSize) {
      case EscPaperSize.mm58:
        paperSize = PaperSize.mm58;
        break;
      case EscPaperSize.mm72:
        paperSize = PaperSize.mm72;
        break;
      case EscPaperSize.mm80:
        paperSize = PaperSize.mm80;
        break;
      default:
        paperSize = PaperSize.mm80;
    }

    /// 如果已经加载过配置文件，直接返回缓存的配置文件
    if (_isProfileLoaded) {
      generator = Generator(
        paperSize,
        _profile!,
        spaceBetweenRows: spaceBetweenRows,
      );
      return generator;
    }

    /// 加载引擎
    final profile = await CapabilityProfile.load();
    _profile = profile;
    _isProfileLoaded = true;
    generator = Generator(
      paperSize,
      profile,
      spaceBetweenRows: spaceBetweenRows,
    );
    return generator;
  }

  /// Open cash drawer
  List<int> drawer({PosDrawer pin = PosDrawer.pin2}) {
    return generator.drawer(pin: pin);
  }

  /// Print an image using (ESC *) command
  ///
  /// [image] is an instance of class from [Image library](https://pub.dev/packages/image)
  List<int> image(
    Image imgSrc, {
    EscPosAlign align = EscPosAlign.center,
    bool isDoubleDensity = true,
  }) {
    return generator.image(
      imgSrc,
      align: escPosAlign(align),
      isDoubleDensity: isDoubleDensity,
    );
  }

  /// Print an image using (GS v 0) obsolete command
  ///
  /// [image] is an instanse of class from [Image library](https://pub.dev/packages/image)
  List<int> imageRaster(
    Image image, {
    EscPosAlign align = EscPosAlign.center,
    bool highDensityHorizontal = true,
    bool highDensityVertical = true,
    // PosImageFn imageFn = PosImageFn.bitImageRaster,
  }) {
    return generator.imageRaster(
      image,
      align: escPosAlign(align),
      highDensityHorizontal: highDensityHorizontal,
      highDensityVertical: highDensityVertical,
      // imageFn: imageFn,
    );
  }

  /// 打印问题
  List<int> text(
    String text, {
    PosStyles? styles = const PosStyles(),
    int linesAfter = 0,
    bool containsChinese = false,
    int? maxCharsPerLine,
  }) {
    return generator.text(
      text,
      styles: styles ?? const PosStyles(),
      linesAfter: linesAfter,
      containsChinese: containsChinese,
      maxCharsPerLine: maxCharsPerLine,
    );
  }

  /// Print a barcode
  ///
  /// [width] range and units are different depending on the printer model (some printers use 1..5). // 条码线条宽度(1~5)
  /// [height] range: 1 - 255. The units depend on the printer model. // 条码高度(点数)
  /// Width, height, font, text position settings are effective until performing of ESC @, reset or power-off.  // 条码文字显示位置
  List<int> barcode(
    Barcode barcode, {
    int? width,
    int? height,
    BarcodeFont? font,
    // BarcodeText textPos = BarcodeText.below,
    PosAlign align = PosAlign.center,
  }) {
    return generator.barcode(
      barcode,
      width: width,
      height: height,
      font: font,
      textPos: BarcodeText.none,
      align: align,
    );
  }

  /// 左右方式的表格
  /// Print a row.
  ///
  /// A row contains up to 12 columns. A column has a width between 1 and 12.
  /// Total width of columns in one row must be equal 12.
  List<int> row(List<PosColumn> cols, {bool multiLine = true}) {
    return generator.row(
      cols,
      multiLine: multiLine,
    );
  }

  /// 画整行虚线
  /// Print horizontal full width separator
  /// If [len] is null, then it will be defined according to the paper width
  List<int> hr({String ch = '-', int? len, int linesAfter = 0}) {
    return generator.hr(
      ch: ch,
      len: len,
      linesAfter: linesAfter,
    );
  }

  /// 打印结束
  /// Cut the paper
  ///
  /// [mode] is used to define the full or partial cut (if supported by the printer)
  List<int> cut({PosCutMode mode = PosCutMode.full}) {
    return generator.cut(
      mode: mode,
    );
  }

  /// Skips [n] lines
  ///
  /// Similar to [emptyLines] but uses an alternative command
  List<int> feed(int n) {
    return generator.feed(n);
  }
}
