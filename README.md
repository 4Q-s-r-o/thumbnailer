# thumbnailer
[![pub package](https://img.shields.io/pub/v/thumbnailer.svg)](https://pub.dartlang.org/packages/thumbnailer)

A Flutter plugin that is able to generate thumbnails for images, pdf and xlsx files
* if thumbnail generation is not supported for specific mime type, then a fallback icon from FontAwesome is returned
* supports registering custom mime type handlers for dynamic extendability
* resulting thumbnail (or fallback icon) is flutter widget
* supports custom resizing/styling of the resulting thumbnail


## Why
In time of creation of this plugin, there was no available solution on pub.dev

## Usage

To use this plugin, add `thumbnailer` as a [dependency in your `pubspec.yaml` file](https://flutter.io/platform-plugins/).

## Icons
By default, plugin provides following icons based on mimetype

| MIME Type                                                                   | Icon                                                                                                                                    |
|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| `image`                                                                     | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/image.svg" width="16" alt="image" />              |
| `application/pdf`                                                           | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-pdf.svg" width="16" alt="pdf" />             |
| `application/msword`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-word.svg" width="16" alt="doc" />            |
| `application/vnd.openxmlformats-officedocument.wordprocessingml.document`   | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-word.svg" width="16" alt="docx"/>            |
| `application/vnd.oasis.opendocument.text`                                   | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-word.svg" width="16" alt="odt" />            |
| `application/vnd.ms-excel`                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-excel.svg" width="16" alt="xls" />           |
| `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-excel.svg" width="16" alt="xlsx"/>           |
| `application/vnd.oasis.opendocument.spreadsheet`                            | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-excel.svg" width="16" alt="ods" />           |
| `application/vnd.ms-powerpoint`                                             | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-powerpoint.svg" width="16" alt="ppt" />      |
| `application/vnd.openxmlformats-officedocument.presentationml.presentation` | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-powerpoint.svg" width="16" alt="pptx"/>      |
| `application/vnd.oasis.opendocument.presentation`                           | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-powerpoint.svg" width="16" alt="odp" />      |
| `text/plain`                                                                | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-lines.svg" width="16" alt="txt" />           |
| `text/csv`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-csv.svg" width="16" alt="csv" />             |
| `application/x-archive`                                                     | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="archive" />      |
| `application/x-cpio`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="cpio" />         |
| `application/x-shar`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="shar" />         |
| `application/x-iso9660-image`                                               | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="iso9660" />      |
| `application/x-sbx`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="sbx" />          |
| `application/x-tar`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="tar" />          |
| `application/x-bzip2`                                                       | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="bzip2" />        |
| `application/gzip`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="gzip" />         |
| `application/x-lzip`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="lzip" />         |
| `application/x-lzma`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="lzma" />         |
| `application/x-lzop`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="lzop" />         |
| `application/x-snappy-framed`                                               | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="snappy" />       |
| `application/x-xz`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="xz" />           |
| `application/x-compress`                                                    | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="compress" />     |
| `application/zstd`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="zstd" />         |
| `application/java-archive`                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="jar" />          |
| `application/octet-stream`                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="octet-stream" /> |
| `application/vnd.android.package-archive`                                   | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="apk" />          |
| `application/vnd.ms-cab-compressed`                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="cab" />          |
| `application/x-7z-compressed`                                               | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="7z" />           |
| `application/x-ace-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="ace" />          |
| `application/x-alz-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="alz" />          |
| `application/x-apple-diskimage`                                             | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="dmg" />          |
| `application/x-arj`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="arj" />          |
| `application/x-astrotite-afa`                                               | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="afa" />          |
| `application/x-b1`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="b1" />           |
| `application/x-cfs-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="cfs" />          |
| `application/x-dar`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="dar" />          |
| `application/x-dgc-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="dgc" />          |
| `application/x-freearc`                                                     | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="arc" />          |
| `application/x-gca-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="gca" />          |
| `application/x-gtar`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="gtar" />         |
| `application/x-lzh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="lzh" />          |
| `application/x-lzx`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="lzx" />          |
| `application/x-ms-wim`                                                      | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="wim" />          |
| `application/x-rar-compressed`                                              | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="rar" />          |
| `application/x-stuffit`                                                     | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="sit" />          |
| `application/x-stuffitx`                                                    | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="sitx" />         |
| `application/x-xar`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="xar" />          |
| `application/x-zoo`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="zoo" />          |
| `application/zip`                                                           | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file-zipper.svg" width="16" alt="zip" />          |
| `text/html`                                                                 | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="html" />                |
| `text/javascript`                                                           | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="js" />                  |
| `text/css`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="css" />                 |
| `text/x-python`                                                             | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="py" />                  |
| `application/x-python-code`                                                 | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="pyo" />                 |
| `text/xml`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="xml" />                 |
| `application/xml`                                                           | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="xml" />                 |
| `text/x-c`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="c" />                   |
| `application/java`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="java" />                |
| `application/java-byte-code`                                                | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="class" />               |
| `application/x-java-class`                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="class" />               |
| `application/x-csh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="csh" />                 |
| `text/x-script.csh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="csh" />                 |
| `text/x-fortran`                                                            | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="f90" />                 |
| `text/x-h`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="h" />                   |
| `application/x-ksh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="ksh" />                 |
| `text/x-script.ksh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="ksh" />                 |
| `application/x-latex`                                                       | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="tex" />                 |
| `application/x-lisp`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="lisp" />                |
| `text/x-script.lisp`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="lisp" />                |
| `text/x-m`                                                                  | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="m" />                   |
| `text/x-pascal`                                                             | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="pas" />                 |
| `text/x-script.perl`                                                        | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="pl" />                  |
| `application/postscript`                                                    | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="ps" />                  |
| `text/x-script.phyton`                                                      | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="py" />                  |
| `application/x-bytecode.python`                                             | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="pyc" />                 |
| `text/x-asm`                                                                | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="asm" />                 |
| `application/x-bsh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="bsh" />                 |
| `application/x-sh`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="sh" />                  |
| `text/x-script.sh`                                                          | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="sh" />                  |
| `text/x-script.zsh`                                                         | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/code.svg" width="16" alt="zsh" />                 |
| `default`                                                                   | <img src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.1/svgs/solid/file.svg" width="16" alt="file" />                |

You can override these, or add custom one using ```Thumbnailer.addCustomMimeTypesToIconDataMappings```

## Generation strategies
Thunbnailer allows you to provide custom thumbnail based on dynamic variables like content of file. Basic implementacion have following generation strategies:

* Images — show inlined image
* PDF — Show highlight of first page
* XLS / ODT — Show highlight of first sheet.

You can extend these using ```Thumbnailer.addCustomGenerationStrategies```

## Example

Check the example tab here in pub.dev or example project on GitHub

## Contribution and Support

* Contributions are welcome!
* If you want to contribute code please create a PR
* If you find a bug or want a feature, please fill an issue
