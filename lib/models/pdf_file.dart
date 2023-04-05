class PdfFile {
  // {
  //         "FILE_NAME": "name 1",
  //         "KOJIIRAISYO_FILEPATH":
  //             "https://www.africau.edu/images/default/sample.pdf",
  //         "JYUCYU_ID": "0301614411",
  //         "HOMON_SBT": "02",
  //         "KOJI_ST": "03",
  //         "SINGLE_SUMMARIZE": "1"
  //       },

  String? kojiiraisyoFileName;
  String? sitamiiraisyoFileName;
  String? kojiiraisyoFilePath;
  String? sitamiiraisyoFilePath;
  List<FileItem>? files;
  String? jyucyuId;
  String? homonSbt;
  String? kojiSt;
  int? singleSumarize;

  PdfFile(
      {this.kojiiraisyoFileName,
      this.sitamiiraisyoFileName,
      this.kojiiraisyoFilePath,
      this.sitamiiraisyoFilePath,
      this.files,
      this.jyucyuId,
      this.homonSbt,
      this.kojiSt,
      this.singleSumarize});

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      kojiiraisyoFileName: json['FILE_NAME_KOJIIRAISYO_FILEPATH'] ?? '',
      sitamiiraisyoFileName: json['FILE_NAME_SITAMIIRAISYO_FILEPATH'] ?? '',
      kojiiraisyoFilePath: json['KOJIIRAISYO_FILEPATH'] ?? '',
      sitamiiraisyoFilePath: json['SITAMIIRAISYO_FILEPATH'] ?? '',
      files: json['FILES'] != null
          ? (json['FILES'] as List).map((i) => FileItem.fromJson(i)).toList()
          : [],
      jyucyuId: json['JYUCYU_ID'] ?? '',
      homonSbt: json['HOMON_SBT'] ?? '',
      kojiSt: json['KOJI_ST'] ?? '',
      singleSumarize: json['SINGLE_SUMMARIZE'] ?? 0,
    );
  }
}

class FileItem {
  final String? name;
  final String? path;

  FileItem({this.name, this.path});

  factory FileItem.fromJson(Map<String, dynamic> json) =>
      FileItem(name: json['name'] ?? '', path: json['path'] ?? '');
}
