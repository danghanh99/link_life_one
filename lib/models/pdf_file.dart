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

  String? fileName;
  String? kojiiraisyoFilePath;
  String? sitamiiraisyoFilePath;
  String? jyucyuId;
  String? homonSbt;
  String? kojiSt;
  int? singleSumarize;

  PdfFile(
      {this.fileName,
      this.kojiiraisyoFilePath,
      this.sitamiiraisyoFilePath,
      this.jyucyuId,
      this.homonSbt,
      this.kojiSt,
      this.singleSumarize});

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      fileName: json['FILE_NAME'] ?? '',
      kojiiraisyoFilePath: json['KOJIIRAISYO_FILEPATH'] ?? '',
      sitamiiraisyoFilePath: json['SITAMIIRAISYO_FILEPATH'] ?? '',
      jyucyuId: json['JYUCYU_ID'] ?? '',
      homonSbt: json['HOMON_SBT'] ?? '',
      kojiSt: json['KOJI_ST'] ?? '',
      singleSumarize: json['SINGLE_SUMMARIZE'] ?? 0,
    );
  }
}
