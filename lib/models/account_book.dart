class AccountBook {
  final String tantoName;
  final String kaisyuRuikei;
  final String nyukinGak;
  final int total;

  AccountBook({
    required this.tantoName,
    required this.kaisyuRuikei,
    required this.nyukinGak,
    required this.total,
  });

  factory AccountBook.fromJson(Map<String, dynamic> json) {
    return AccountBook(
      tantoName: json["TANT_NAME"],
      kaisyuRuikei: json["KAISYU_RUIKEI"],
      nyukinGak: json["NYUKIN_GAK"],
      total: json["total"],
    );
  }
}
