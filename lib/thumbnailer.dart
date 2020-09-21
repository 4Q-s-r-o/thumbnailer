import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

/// Main class for thumbnailer plugin
class Thumbnailer {
  ///Map which contains mimeType-IconData relation
  static final Map<String, IconData> _mimeTypeToIconDataMap = <String, IconData>{
    'image': FontAwesomeIcons.image,
    'application/pdf': FontAwesomeIcons.filePdf,
    'application/msword': FontAwesomeIcons.fileWord,
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
        FontAwesomeIcons.fileWord,
    'application/vnd.oasis.opendocument.text': FontAwesomeIcons.fileWord,
    'application/vnd.ms-excel': FontAwesomeIcons.fileExcel,
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': FontAwesomeIcons.fileExcel,
    'application/vnd.oasis.opendocument.spreadsheet': FontAwesomeIcons.fileExcel,
    'application/vnd.ms-powerpoint': FontAwesomeIcons.filePowerpoint,
    'application/vnd.openxmlformats-officedocument.presentationml.presentation':
        FontAwesomeIcons.filePowerpoint,
    'application/vnd.oasis.opendocument.presentation': FontAwesomeIcons.filePowerpoint,
    'text/plain': FontAwesomeIcons.fileAlt,
    'text/csv': FontAwesomeIcons.fileCsv,
    'application/x-archive': FontAwesomeIcons.fileArchive,
    'application/x-cpio': FontAwesomeIcons.fileArchive,
    'application/x-shar': FontAwesomeIcons.fileArchive,
    'application/x-iso9660-image': FontAwesomeIcons.fileArchive,
    'application/x-sbx': FontAwesomeIcons.fileArchive,
    'application/x-tar': FontAwesomeIcons.fileArchive,
    'application/x-bzip2': FontAwesomeIcons.fileArchive,
    'application/gzip': FontAwesomeIcons.fileArchive,
    'application/x-lzip': FontAwesomeIcons.fileArchive,
    'application/x-lzma': FontAwesomeIcons.fileArchive,
    'application/x-lzop': FontAwesomeIcons.fileArchive,
    'application/x-snappy-framed': FontAwesomeIcons.fileArchive,
    'application/x-xz': FontAwesomeIcons.fileArchive,
    'application/x-compress': FontAwesomeIcons.fileArchive,
    'application/zstd': FontAwesomeIcons.fileArchive,
    'application/java-archive': FontAwesomeIcons.fileArchive,
    'application/octet-stream': FontAwesomeIcons.fileArchive,
    'application/vnd.android.package-archive': FontAwesomeIcons.fileArchive,
    'application/vnd.ms-cab-compressed': FontAwesomeIcons.fileArchive,
    'application/x-7z-compressed': FontAwesomeIcons.fileArchive,
    'application/x-ace-compressed': FontAwesomeIcons.fileArchive,
    'application/x-alz-compressed': FontAwesomeIcons.fileArchive,
    'application/x-apple-diskimage': FontAwesomeIcons.fileArchive,
    'application/x-arj': FontAwesomeIcons.fileArchive,
    'application/x-astrotite-afa': FontAwesomeIcons.fileArchive,
    'application/x-b1': FontAwesomeIcons.fileArchive,
    'application/x-cfs-compressed': FontAwesomeIcons.fileArchive,
    'application/x-dar': FontAwesomeIcons.fileArchive,
    'application/x-dgc-compressed': FontAwesomeIcons.fileArchive,
    'application/x-freearc': FontAwesomeIcons.fileArchive,
    'application/x-gca-compressed': FontAwesomeIcons.fileArchive,
    'application/x-gtar': FontAwesomeIcons.fileArchive,
    'application/x-lzh': FontAwesomeIcons.fileArchive,
    'application/x-lzx': FontAwesomeIcons.fileArchive,
    'application/x-ms-wim': FontAwesomeIcons.fileArchive,
    'application/x-rar-compressed': FontAwesomeIcons.fileArchive,
    'application/x-stuffit': FontAwesomeIcons.fileArchive,
    'application/x-stuffitx': FontAwesomeIcons.fileArchive,
    'application/x-xar': FontAwesomeIcons.fileArchive,
    'application/x-zoo': FontAwesomeIcons.fileArchive,
    'application/zip': FontAwesomeIcons.fileArchive,
    'text/html': FontAwesomeIcons.code,
    'text/javascript': FontAwesomeIcons.code,
    'text/css': FontAwesomeIcons.code,
    'text/x-python': FontAwesomeIcons.code,
    'application/x-python-code': FontAwesomeIcons.code,
    'text/xml': FontAwesomeIcons.code,
    'application/xml': FontAwesomeIcons.code,
    'text/x-c': FontAwesomeIcons.code,
    'application/java': FontAwesomeIcons.code,
    'application/java-byte-code': FontAwesomeIcons.code,
    'application/x-java-class': FontAwesomeIcons.code,
    'application/x-csh': FontAwesomeIcons.code,
    'text/x-script.csh': FontAwesomeIcons.code,
    'text/x-fortran': FontAwesomeIcons.code,
    'text/x-h': FontAwesomeIcons.code,
    'application/x-ksh': FontAwesomeIcons.code,
    'text/x-script.ksh': FontAwesomeIcons.code,
    'application/x-latex': FontAwesomeIcons.code,
    'application/x-lisp': FontAwesomeIcons.code,
    'text/x-script.lisp': FontAwesomeIcons.code,
    'text/x-m': FontAwesomeIcons.code,
    'text/x-pascal': FontAwesomeIcons.code,
    'text/x-script.perl': FontAwesomeIcons.code,
    'application/postscript': FontAwesomeIcons.code,
    'text/x-script.phyton': FontAwesomeIcons.code,
    'application/x-bytecode.python': FontAwesomeIcons.code,
    'text/x-asm': FontAwesomeIcons.code,
    'application/x-bsh': FontAwesomeIcons.code,
    'application/x-sh': FontAwesomeIcons.code,
    'text/x-script.sh': FontAwesomeIcons.code,
    'text/x-script.zsh': FontAwesomeIcons.code,
  };

  ///Map which contains strategy of creating thumbnail widget
  static final Map<String, GenerationStrategyFunction> generationStrategies =
      <String, GenerationStrategyFunction>{
    'image': (
      String name,
      String mimeType,
      int dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration widgetDecoration,
    ) async {
      final Uint8List resolvedData = await getData();
      if (resolvedData != null) {
        return Center(
          child: Image.memory(
            resolvedData,
            fit: BoxFit.fitWidth,
            semanticLabel: name,
            width: widgetSize,
            filterQuality: FilterQuality.none,
          ),
        );
      }
      return null;
    },
    'application/pdf': (
      String name,
      String mimeType,
      int dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration widgetDecoration,
    ) async {
      final Uint8List resolvedData = await getData();
      if (resolvedData != null) {
        final PdfDocument document = await PdfDocument.openData(resolvedData);
        final PdfPage page = await document.getPage(1);
        final PdfPageImage pageImage = await page.render(width: page.width, height: page.height);
        return Center(
          child: Image.memory(
            pageImage.bytes,
            fit: BoxFit.fitWidth,
            semanticLabel: name,
            width: widgetSize,
            filterQuality: FilterQuality.none,
          ),
        );
      }
      return null;
    },
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': (
      String name,
      String mimeType,
      int dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration decoration,
    ) =>
        _xlsxAndOdsCreationStrategy(name, getData, mimeType, dataSize, widgetSize, decoration),
    'application/vnd.oasis.opendocument.spreadsheet': (
      String name,
      String mimeType,
      int dataSize,
      DataResolvingFunction getData,
      double widgetSize,
      WidgetDecoration decoration,
    ) =>
        _xlsxAndOdsCreationStrategy(name, getData, mimeType, dataSize, widgetSize, decoration),
  };

  /// spreadsheet_decoder supports these 2 mime types
  static Future<Widget> _xlsxAndOdsCreationStrategy(
    String name,
    DataResolvingFunction dataResolver,
    String mimeType,
    int dataSize,
    double widgetSize,
    WidgetDecoration decoration,
  ) async {
    final Uint8List resolvedData = await dataResolver();
    if (resolvedData != null) {
      final SpreadsheetDecoder decoder = SpreadsheetDecoder.decodeBytes(resolvedData.toList());
      final List<List<dynamic>> rowsS = decoder.tables.entries.first.value.rows;
      final int columnsCount = rowsS.length > widgetSize ~/ 17 ? widgetSize ~/ 17 : rowsS.length;
      final int rowsCount =
          rowsS.first.length > widgetSize ~/ 30 ? widgetSize ~/ 30 : rowsS.first.length;
      final List<Row> rows = <Row>[];
      final double rowWidth = widgetSize / (rowsCount + 1);
      final double rowHeight = widgetSize / columnsCount;
      final double fontSize = rowWidth > rowHeight ? rowHeight / 3 : rowWidth / 6;

      for (int i = 0; i < columnsCount; i++) {
        final List<Widget> rowWidgets = <Widget>[];
        for (int j = 0; j < rowsCount; j++) {
          if (i == 0) {
            if (j == 0) {
              rowWidgets.add(
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(220, 220, 220, 0.9),
                    border: Border(
                      right: BorderSide(width: widgetSize / 300),
                      bottom: BorderSide(width: widgetSize / 300),
                      top: BorderSide(width: widgetSize / 300),
                      left: BorderSide(width: widgetSize / 300),
                    ),
                  ),
                  width: rowWidth,
                  height: rowHeight,
                  child: Center(
                    child: Text(
                      ' ',
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              );
            }
            rowWidgets.add(
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(220, 220, 220, 0.9),
                  border: Border(
                    right: BorderSide(width: widgetSize / 300),
                    bottom: BorderSide(width: widgetSize / 300),
                    top: BorderSide(width: widgetSize / 300),
                  ),
                ),
                width: rowWidth,
                height: rowHeight,
                child: Center(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Text(
                        '${rowsS.elementAt(i).elementAt(j) ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: (constraints.maxHeight / fontSize).floor(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            if (j == 0) {
              rowWidgets.add(
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(220, 220, 220, 0.9),
                    border: Border(
                      right: BorderSide(width: widgetSize / 300),
                      bottom: BorderSide(width: widgetSize / 300),
                      left: BorderSide(width: widgetSize / 300),
                    ),
                  ),
                  width: rowWidth,
                  height: rowHeight,
                  child: Center(
                    child: Text(
                      '$i',
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              );
            }
            rowWidgets.add(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: widgetSize / 300),
                    bottom: BorderSide(width: widgetSize / 300),
                  ),
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
                          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
        }
        rows.add(
          Row(children: rowWidgets),
        );
      }

      return Column(
        children: rows,
        mainAxisAlignment: MainAxisAlignment.start,
      );
    }
    return null;
  }

  ///Adds custom mappings to [_mimeTypeToIconDataMap]
  static void addCustomMimeTypesToIconDataMappings(Map<String, IconData> mappings) {
    _mimeTypeToIconDataMap.addAll(mappings);
  }

  ///Adds custom strategies to [generationStrategies]
  static void addCustomGenerationStrategies(Map<String, GenerationStrategyFunction> strategies) {
    generationStrategies.addAll(strategies);
  }

  ///Returns IconData for given mimeType
  static IconData getIconDataForMimeType(String mimeType) {
    return _mimeTypeToIconDataMap[mimeType];
  }
}

/// Thumbnail widget
///
/// dataResolver can be defined as dataResolver: () => null, but in this case custom creation
/// strategies in [Thumbnailer.generationStrategies] has to be aware of null value
class Thumbnail extends StatefulWidget {
  ///constructor
  const Thumbnail({
    @required this.mimeType,
    @required this.widgetSize,
    this.dataResolver,
    Key key,
    this.dataSize,
    this.name,
    this.decoration,
    this.onlyIcon,
  }) : super(key: key);

  /// If non-null, the style to use for this thumbnail.
  final WidgetDecoration decoration;

  /// Name of file which is used to create watermark.
  final String name;

  /// Function which returns Uint8List representation of used file
  final DataResolvingFunction dataResolver;

  /// Mime type of used file
  final String mimeType;

  /// Size of used file
  final int dataSize;

  /// Size of generated thumbnail without wrapper
  final double widgetSize;

  /// Should be used icon instead of widget from [Thumbnailer.generationStrategies]
  final bool onlyIcon;

  @override
  ThumbnailState createState() => ThumbnailState();
}

/// state for FileThumbnail widget
class ThumbnailState extends State<Thumbnail> {
  Future<Widget> _thumbnailFuture;

  @override
  void initState() {
    super.initState();
    final GenerationStrategyFunction generationStrategyFunction = _getIconByMimeType(
      Thumbnailer.generationStrategies,
      widget.mimeType,
      '/',
    );
    if (generationStrategyFunction != null) {
      _thumbnailFuture = generationStrategyFunction(
        widget.name,
        widget.mimeType,
        widget.dataSize,
        widget.dataResolver,
        widget.widgetSize,
        widget.decoration,
      );
    } else {
      _thumbnailFuture = Future<Widget>.delayed(Duration.zero, () async => null);
    }
  }

  // REVIEW: prepisat tak, aby najprv zistil ci existuje strategia. ak ano, vraciame FutureWidget, ak
  // nie, vraciame ikonu. Ak generovanie zlyha, fallback je ikona. Generovanie ikony aj s wrapovanim
  // teda musi ist do separe metody a bude volana na dvoch miestach
  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    final IconData iconData = _getIconByMimeType(
      Thumbnailer._mimeTypeToIconDataMap,
      widget.mimeType,
      '/',
    );
    if (iconData != null) {
      final WidgetDecoration wd = widget.decoration;
      iconWidget = _applyMetadataWatermark(Icon(
        iconData,
        size: widget.widgetSize * 0.3,
        color: wd?.iconColor ?? Colors.black,
      ));
      if (widget.onlyIcon ?? false) {
        if (iconWidget != null) {
          return iconWidget = _wrapThumbnail(iconWidget);
        } else {
          throw FileThumbnailsException(
            message: "Couldn't create thumbnail, unknown mime type: ${widget.mimeType}."
                " Didn't you forget to register custom mimetype/icon mapping?",
          );
        }
      }
    }
    return FutureBuilder<Widget>(
      future: _thumbnailFuture,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null || iconWidget != null) {
            return _wrapThumbnail(snapshot.data ?? iconWidget);
          }
          throw FileThumbnailsException(
            message: "Couldn't create thumbnail, unknown mime type: ${widget.mimeType}."
                " Didn't you forget to register custom generation strategy?",
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
  }

  ///Internal helper function which extracts [T] value from [mapToExtractFrom].
  ///Function is cutting from end of [mimeType] until [mimeType] contains [divider] or map keys
  ///contains cut string
  static T _getIconByMimeType<T>(Map<String, T> mapToExtractFrom, String mimeType, String divider) {
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
    return null;
  }

  //REVIEW: inlajnovat do buducej metody generujucej ikonu
  Widget _wrapThumbnail(Widget thumbnail) {
    return Container(
      width: widget.decoration?.wrapperSize ?? widget.widgetSize,
      height: widget.decoration?.wrapperSize ?? widget.widgetSize,
      decoration: BoxDecoration(color: widget.decoration?.wrapperBgColor ?? Colors.black26),
      child: thumbnail,
    );
  }

  // REVIEW: dat moznost ci aplikovat watermark (default true)
  ///Applies watermark (file name and file size) on widget (used just for icons)
  Widget _applyMetadataWatermark(Widget widget) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: this.widget.widgetSize,
            height: this.widget.widgetSize,
            decoration: BoxDecoration(
              color: this.widget.decoration?.backgroundColor ?? Colors.black26,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: widget,
          ),
          if (this.widget.name != null)
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                width: this.widget.widgetSize,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Center(
                    child: Text(
                      '${this.widget.name}',
                      style: TextStyle(
                        fontSize: 12,
                        color: this.widget.decoration?.textColor ?? Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (this.widget.dataSize != null)
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                '${(this.widget.dataSize / 1024).floor()} kB',
                style: TextStyle(
                  fontSize: 11,
                  color: this.widget.decoration?.textColor ?? Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

///Exception which is thrown in case where [Thumbnail] couldn't create thumbnail
class FileThumbnailsException implements Exception {
  /// constructor
  FileThumbnailsException({@required this.message});

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
  WidgetDecoration({
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.wrapperSize,
    this.wrapperBgColor,
  });

  /// Color to fill in the background of the thumbnail.
  final Color backgroundColor;

  /// Color to use when painting the text.
  final Color textColor;

  /// Color to use when painting the icon.
  final Color iconColor;

  /// Size of box in which is widget wrapped
  final double wrapperSize;

  /// Color to fill in the background of the wrapper.
  final Color wrapperBgColor;
}

/// type definition for functions delivering thumbnail generation strategy for specific mime type
typedef GenerationStrategyFunction = Future<Widget> Function(
  String name,
  String mimeType,
  int dataSize,
  DataResolvingFunction dataResolver,
  double widgetSize,
  WidgetDecoration decoration,
);

/// type definitions for functions delivering raw binary data used for thumbnail generation
typedef DataResolvingFunction = Future<Uint8List> Function();
