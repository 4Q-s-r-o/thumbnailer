import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdfx/pdfx.dart';
import 'package:table_parser/table_parser.dart';

/// Main class for thumbnailer plugin
class Thumbnailer {
  ///Map which contains mimeType-IconData relation
  static final Map<String, IconData> _mimeTypeToIconDataMap = <String, IconData>{
    'image': FontAwesomeIcons.image.data,
    'application/pdf': FontAwesomeIcons.filePdf.data,
    'application/msword': FontAwesomeIcons.fileWord.data,
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': FontAwesomeIcons.fileWord.data,
    'application/vnd.oasis.opendocument.text': FontAwesomeIcons.fileWord.data,
    'application/vnd.ms-excel': FontAwesomeIcons.fileExcel.data,
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': FontAwesomeIcons.fileExcel.data,
    'application/vnd.oasis.opendocument.spreadsheet': FontAwesomeIcons.fileExcel.data,
    'application/vnd.ms-powerpoint': FontAwesomeIcons.filePowerpoint.data,
    'application/vnd.openxmlformats-officedocument.presentationml.presentation': FontAwesomeIcons.filePowerpoint.data,
    'application/vnd.oasis.opendocument.presentation': FontAwesomeIcons.filePowerpoint.data,
    'text/plain': FontAwesomeIcons.fileLines.data,
    'text/csv': FontAwesomeIcons.fileCsv.data,
    'application/x-archive': FontAwesomeIcons.fileZipper.data,
    'application/x-cpio': FontAwesomeIcons.fileZipper.data,
    'application/x-shar': FontAwesomeIcons.fileZipper.data,
    'application/x-iso9660-image': FontAwesomeIcons.fileZipper.data,
    'application/x-sbx': FontAwesomeIcons.fileZipper.data,
    'application/x-tar': FontAwesomeIcons.fileZipper.data,
    'application/x-bzip2': FontAwesomeIcons.fileZipper.data,
    'application/gzip': FontAwesomeIcons.fileZipper.data,
    'application/x-lzip': FontAwesomeIcons.fileZipper.data,
    'application/x-lzma': FontAwesomeIcons.fileZipper.data,
    'application/x-lzop': FontAwesomeIcons.fileZipper.data,
    'application/x-snappy-framed': FontAwesomeIcons.fileZipper.data,
    'application/x-xz': FontAwesomeIcons.fileZipper.data,
    'application/x-compress': FontAwesomeIcons.fileZipper.data,
    'application/zstd': FontAwesomeIcons.fileZipper.data,
    'application/java-archive': FontAwesomeIcons.fileZipper.data,
    'application/octet-stream': FontAwesomeIcons.fileZipper.data,
    'application/vnd.android.package-archive': FontAwesomeIcons.fileZipper.data,
    'application/vnd.ms-cab-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-7z-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-ace-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-alz-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-apple-diskimage': FontAwesomeIcons.fileZipper.data,
    'application/x-arj': FontAwesomeIcons.fileZipper.data,
    'application/x-astrotite-afa': FontAwesomeIcons.fileZipper.data,
    'application/x-b1': FontAwesomeIcons.fileZipper.data,
    'application/x-cfs-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-dar': FontAwesomeIcons.fileZipper.data,
    'application/x-dgc-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-freearc': FontAwesomeIcons.fileZipper.data,
    'application/x-gca-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-gtar': FontAwesomeIcons.fileZipper.data,
    'application/x-lzh': FontAwesomeIcons.fileZipper.data,
    'application/x-lzx': FontAwesomeIcons.fileZipper.data,
    'application/x-ms-wim': FontAwesomeIcons.fileZipper.data,
    'application/x-rar-compressed': FontAwesomeIcons.fileZipper.data,
    'application/x-stuffit': FontAwesomeIcons.fileZipper.data,
    'application/x-stuffitx': FontAwesomeIcons.fileZipper.data,
    'application/x-xar': FontAwesomeIcons.fileZipper.data,
    'application/x-zoo': FontAwesomeIcons.fileZipper.data,
    'application/zip': FontAwesomeIcons.fileZipper.data,
    'text/html': FontAwesomeIcons.code.data,
    'text/javascript': FontAwesomeIcons.code.data,
    'text/css': FontAwesomeIcons.code.data,
    'text/x-python': FontAwesomeIcons.code.data,
    'application/x-python-code': FontAwesomeIcons.code.data,
    'text/xml': FontAwesomeIcons.code.data,
    'application/xml': FontAwesomeIcons.code.data,
    'text/x-c': FontAwesomeIcons.code.data,
    'application/java': FontAwesomeIcons.code.data,
    'application/java-byte-code': FontAwesomeIcons.code.data,
    'application/x-java-class': FontAwesomeIcons.code.data,
    'application/x-csh': FontAwesomeIcons.code.data,
    'text/x-script.csh': FontAwesomeIcons.code.data,
    'text/x-fortran': FontAwesomeIcons.code.data,
    'text/x-h': FontAwesomeIcons.code.data,
    'application/x-ksh': FontAwesomeIcons.code.data,
    'text/x-script.ksh': FontAwesomeIcons.code.data,
    'application/x-latex': FontAwesomeIcons.code.data,
    'application/x-lisp': FontAwesomeIcons.code.data,
    'text/x-script.lisp': FontAwesomeIcons.code.data,
    'text/x-m': FontAwesomeIcons.code.data,
    'text/x-pascal': FontAwesomeIcons.code.data,
    'text/x-script.perl': FontAwesomeIcons.code.data,
    'application/postscript': FontAwesomeIcons.code.data,
    'text/x-script.phyton': FontAwesomeIcons.code.data,
    'application/x-bytecode.python': FontAwesomeIcons.code.data,
    'text/x-asm': FontAwesomeIcons.code.data,
    'application/x-bsh': FontAwesomeIcons.code.data,
    'application/x-sh': FontAwesomeIcons.code.data,
    'text/x-script.sh': FontAwesomeIcons.code.data,
    'text/x-script.zsh': FontAwesomeIcons.code.data,
    'default': FontAwesomeIcons.file.data,
  };

  ///Map which contains strategy of creating thumbnail widget
  static final Map<String, GenerationStrategyFunction> _generationStrategies = <String, GenerationStrategyFunction>{
    'image': (
      String? name,
      String mimeType,
      int? dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration? widgetDecoration,
    ) async {
      final Uint8List resolvedData = await getData();
      return Center(
        child: Image.memory(
          resolvedData,
          fit: BoxFit.fitWidth,
          semanticLabel: name,
          width: widgetSize,
          filterQuality: FilterQuality.none,
        ),
      );
    },
    'application/pdf': (
      String? name,
      String mimeType,
      int? dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration? widgetDecoration,
    ) async {
      final Uint8List resolvedData = await getData();
      final PdfDocument document = await PdfDocument.openData(resolvedData);
      final PdfPage page = await document.getPage(1);
      final PdfPageImage pageImage = (await page.render(width: page.width, height: page.height))!;
      // ignore: unawaited_futures
      Future.wait<void>(<Future<void>>[page.close(), document.close()]);
      return Center(
        child: Image.memory(
          pageImage.bytes,
          fit: BoxFit.fitWidth,
          semanticLabel: name,
          width: widgetSize,
          filterQuality: FilterQuality.none,
        ),
      );
    },
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        (
          String? name,
          String mimeType,
          int? dataSize,
          DataResolvingFunction getData,
          double widgetSize,
          WidgetDecoration? decoration,
        ) => _xlsxAndOdsCreationStrategy(name, getData, mimeType, dataSize, widgetSize, decoration),
    'application/vnd.oasis.opendocument.spreadsheet':
        (
          String? name,
          String mimeType,
          int? dataSize,
          DataResolvingFunction getData,
          double widgetSize,
          WidgetDecoration? decoration,
        ) => _xlsxAndOdsCreationStrategy(name, getData, mimeType, dataSize, widgetSize, decoration),
  };

  /// spreadsheet_decoder supports these 2 mime types
  static Future<Widget> _xlsxAndOdsCreationStrategy(
    String? name,
    DataResolvingFunction dataResolver,
    String mimeType,
    int? dataSize,
    double widgetSize,
    WidgetDecoration? decoration,
  ) async {
    assert(decoration != null);
    final Uint8List resolvedData = await dataResolver();
    final TableParser decoder = TableParser.decodeBytes(resolvedData.toList());
    final List<List<dynamic>> rowsS = decoder.tables.entries.first.value.rows;
    final int columnsCount = rowsS.length > widgetSize ~/ 17 ? widgetSize ~/ 17 : rowsS.length;
    final int rowsCount = rowsS.first.length > widgetSize ~/ 30 ? widgetSize ~/ 30 : rowsS.first.length;
    final List<Row> rows = <Row>[];
    final double rowWidth = widgetSize / (rowsCount + 1);
    final double rowHeight = widgetSize / columnsCount;
    final double fontSize = rowWidth > rowHeight ? rowHeight / 3 : rowWidth / 6;

    for (int i = 0; i < columnsCount; i++) {
      final List<Widget> rowWidgets = <Widget>[];
      for (int j = 0; j < rowsCount; j++) {
        if (i == 0) {
          if (j == 0) {
            //view selector
            rowWidgets.add(
              _createCell(
                text: ' ',
                rowHeight: rowHeight,
                rowWidth: rowWidth,
                fontSize: fontSize,
                border: Border.fromBorderSide(BorderSide(width: widgetSize / 300)),
                textColor: decoration!.textColor,
              ),
            );
          }
          //column headers
          rowWidgets.add(
            _createCell(
              text: String.fromCharCode(j + 65),
              rowHeight: rowHeight,
              rowWidth: rowWidth,
              fontSize: fontSize,
              border: Border(
                right: BorderSide(width: widgetSize / 300),
                bottom: BorderSide(width: widgetSize / 300),
                top: BorderSide(width: widgetSize / 300),
              ),
              textColor: decoration!.textColor,
            ),
          );
        } else {
          if (j == 0) {
            //row headers
            rowWidgets.add(
              _createCell(
                text: '$i',
                rowHeight: rowHeight,
                rowWidth: rowWidth,
                fontSize: fontSize,
                border: Border(
                  right: BorderSide(width: widgetSize / 300),
                  bottom: BorderSide(width: widgetSize / 300),
                  left: BorderSide(width: widgetSize / 300),
                ),
                textColor: decoration!.textColor,
              ),
            );
          }
          rowWidgets.add(
            //cells
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(right: BorderSide(width: widgetSize / 300), bottom: BorderSide(width: widgetSize / 300)),
              ),
              width: rowWidth,
              height: rowHeight,
              child: Center(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Padding(
                      padding: EdgeInsets.only(left: rowWidth / 50, right: rowWidth / 50),
                      child: Text(
                        '${rowsS.elementAt(i).elementAt(j) ?? ' '}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: (constraints.maxHeight / fontSize).floor(),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900, color: decoration!.textColor),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
      }
      rows.add(Row(children: rowWidgets));
    }

    return Column(children: rows, mainAxisAlignment: MainAxisAlignment.start);
  }

  ///Internal helper function which creates decorated table cell
  ///used for row headers, column headers and view selector in [_xlsxAndOdsCreationStrategy]
  static Widget _createCell({
    required String text,
    required double rowHeight,
    required double rowWidth,
    required double fontSize,
    required Border border,
    required Color? textColor,
  }) {
    return Container(
      decoration: BoxDecoration(color: const Color.fromRGBO(220, 220, 220, 0.9), border: border),
      width: rowWidth,
      height: rowHeight,
      child: Center(
        child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900, color: textColor)),
      ),
    );
  }

  ///Adds custom mappings to [_mimeTypeToIconDataMap]
  static void addCustomMimeTypesToIconDataMappings(Map<String, IconData> mappings) {
    _mimeTypeToIconDataMap.addAll(mappings);
  }

  ///Adds custom strategies to [_generationStrategies]
  static void addCustomGenerationStrategies(Map<String, GenerationStrategyFunction> strategies) {
    _generationStrategies.addAll(strategies);
  }

  ///Returns IconData for given mimeType
  static IconData? getIconDataForMimeType(String mimeType) {
    return _mimeTypeToIconDataMap[mimeType];
  }
}

/// Thumbnail widget
///
/// dataResolver can be defined as dataResolver: () => null, but in this case custom creation
/// strategies in [Thumbnailer._generationStrategies] has to be aware of null value
class Thumbnail extends StatefulWidget {
  ///constructor
  const Thumbnail({
    required this.mimeType,
    required this.widgetSize,
    this.dataResolver,
    Key? key,
    this.dataSize,
    this.name,
    this.decoration,
    this.onlyIcon,
    this.useWaterMark,
    this.useWrapper,
    this.onlyName,
    this.errorBuilder,
  }) : super(key: key);

  /// If non-null, the style to use for this thumbnail.
  final WidgetDecoration? decoration;

  /// Name of file which is used to create watermark.
  final String? name;

  /// Function which returns Uint8List representation of used file
  final DataResolvingFunction? dataResolver;

  /// Mime type of used file
  final String mimeType;

  /// Size of used file
  final int? dataSize;

  /// Size of generated thumbnail without wrapper
  final double widgetSize;

  /// Should be used icon instead of widget from [Thumbnailer._generationStrategies]
  final bool? onlyIcon;

  /// Should create watermark and apply for thumbnail
  final bool? useWaterMark;

  /// Should be thumbnail wrapped
  final bool? useWrapper;

  /// Show only name for watermark thumbnail
  final bool? onlyName;

  /// Show widget loading error for thumbnail
  final Widget Function(BuildContext, Exception error)? errorBuilder;

  @override
  ThumbnailState createState() => ThumbnailState();
}

/// state for Thumbnail widget
class ThumbnailState extends State<Thumbnail> {
  Future<Widget>? _thumbnailFuture;

  @override
  void initState() {
    super.initState();
    final GenerationStrategyFunction? generationStrategyFunction = _getIconByMimeType(
      Thumbnailer._generationStrategies,
      widget.mimeType,
      '/',
    );
    if (generationStrategyFunction != null) {
      assert(widget.dataResolver != null);
      _thumbnailFuture = generationStrategyFunction(
        widget.name,
        widget.mimeType,
        widget.dataSize,
        widget.dataResolver!,
        widget.widgetSize,
        widget.decoration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbnailFuture != null && !(widget.onlyIcon ?? false)) {
      return FutureBuilder<Widget>(
        future: _thumbnailFuture,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasError) {
            if (widget.errorBuilder != null) {
              return widget.errorBuilder!.call(context, Exception(snapshot.error!.toString()));
            } else {
              // ignore: only_throw_errors
              throw snapshot.error!;
            }
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return _wrapThumbnail(
              _applyMetadataWatermark(
                widget.onlyName ?? false ? snapshot.data ?? Container() : snapshot.data ?? _createIcon(),
              ),
            );
          } else {
            return Container(
              child: const Center(child: CircularProgressIndicator()),
              width: widget.widgetSize,
              height: widget.widgetSize,
              decoration: BoxDecoration(color: widget.decoration?.backgroundColor ?? Colors.black45),
            );
          }
        },
      );
    } else {
      return _wrapThumbnail(_applyMetadataWatermark(widget.onlyName ?? false ? Container() : _createIcon()));
    }
  }

  ///Creates icon if [Thumbnailer._mimeTypeToIconDataMap] contains widget.mimeType if not throws error
  Widget _createIcon() {
    final IconData? iconData = _getIconByMimeType(Thumbnailer._mimeTypeToIconDataMap, widget.mimeType, '/');
    if (iconData != null) {
      final WidgetDecoration? wd = widget.decoration;
      return Icon(iconData, size: widget.widgetSize * 0.3, color: wd?.iconColor ?? Colors.black);
    } else {
      throw FileThumbnailsException(
        message:
            "Couldn't create thumbnail, unknown mime type: ${widget.mimeType}."
            " Didn't you forget to register custom mimetype/icon mapping?",
      );
    }
  }

  ///Internal helper function which extracts [T] value from [mapToExtractFrom].
  ///Function is cutting from end of [mimeType] until [mimeType] contains [divider] or map keys
  ///contains cut string
  static T? _getIconByMimeType<T>(Map<String, T> mapToExtractFrom, String mimeType, String divider) {
    if (mapToExtractFrom.containsKey(mimeType)) {
      return mapToExtractFrom[mimeType];
    }
    String mimeTypePart = mimeType;
    while (mimeTypePart.contains(divider)) {
      mimeTypePart = mimeTypePart.substring(0, mimeTypePart.lastIndexOf(divider));
      if (mapToExtractFrom.containsKey(mimeTypePart)) {
        return mapToExtractFrom[mimeTypePart];
      }
    }
    return mapToExtractFrom['default'];
  }

  ///Wraps thumbnail if (widget.useWrapper ?? true)
  Widget _wrapThumbnail(Widget thumbnail) {
    if (widget.useWrapper ?? true) {
      return Container(
        width: widget.decoration?.wrapperSize ?? widget.widgetSize,
        height: widget.decoration?.wrapperSize ?? widget.widgetSize,
        decoration: BoxDecoration(color: widget.decoration?.wrapperBgColor ?? Colors.transparent),
        child: thumbnail,
      );
    } else {
      return thumbnail;
    }
  }

  ///Applies watermark (file name and file size) on widget if (widget.useWaterMark ?? true)
  ///Applies watermark (file name) on widget if (widget.onlyName ?? true)
  ///Positions of name and dataSize are fixed
  Widget _applyMetadataWatermark(Widget thumbnail) {
    final double heightWidget = widget.widgetSize * (widget.onlyName ?? false ? 1 : 0.35);
    final int numberOfLinesInNameWidget = (heightWidget - 5) ~/ 11;
    if (widget.useWaterMark ?? true) {
      return Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: widget.widgetSize,
              height: widget.widgetSize,
              decoration: BoxDecoration(
                color: widget.decoration?.backgroundColor ?? Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: thumbnail,
            ),
            Column(
              children: <Widget>[
                if (widget.dataSize != null && !(widget.onlyName ?? false))
                  Container(
                    height: heightWidget,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                              child: Text(
                                '${(widget.dataSize! / 1024).floor()} kB',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 11, color: widget.decoration?.textColor ?? Colors.black),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (!(widget.onlyName ?? false)) Container(height: 0.3 * widget.widgetSize),
                if (widget.name != null)
                  Container(
                    height: heightWidget,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5, top: 2, bottom: 3),
                      height: (numberOfLinesInNameWidget * 11.0) + 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '${widget.name}',
                            maxLines: numberOfLinesInNameWidget,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textScaler: const TextScaler.linear(1.0),
                            style: TextStyle(
                              color: widget.decoration?.textColor ?? Colors.black,
                              fontSize: 11,
                              height: 1,
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    } else {
      return thumbnail;
    }
  }
}

///Exception which is thrown in case where [Thumbnail] couldn't create thumbnail
class FileThumbnailsException implements Exception {
  /// constructor
  FileThumbnailsException({required this.message});

  ///Message of exception
  final String message;

  @override
  String toString() {
    return message;
  }
}

/// Description of how to paint a [Thumbnail].
class WidgetDecoration {
  ///constructor
  WidgetDecoration({this.backgroundColor, this.textColor, this.iconColor, this.wrapperSize, this.wrapperBgColor});

  /// Color to fill in the background of the thumbnail.
  final Color? backgroundColor;

  /// Color to use when painting the text.
  final Color? textColor;

  /// Color to use when painting the icon.
  final Color? iconColor;

  /// Size of box in which is widget wrapped
  final double? wrapperSize;

  /// Color to fill in the background of the wrapper.
  final Color? wrapperBgColor;
}

/// type definition for functions delivering thumbnail generation strategy for specific mime type
typedef GenerationStrategyFunction =
    Future<Widget> Function(
      String? name,
      String mimeType,
      int? dataSize,
      DataResolvingFunction dataResolver,
      double widgetSize,
      WidgetDecoration? decoration,
    );

/// type definitions for functions delivering raw binary data used for thumbnail generation
typedef DataResolvingFunction = Future<Uint8List> Function();
