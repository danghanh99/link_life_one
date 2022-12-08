class Month {
  final String formatedDate;
  final String tantoCd;

  Month({
    required this.formatedDate,
    required this.tantoCd,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      formatedDate: json["FORMATED_DATE"],
      tantoCd: json["TANT_CD"],
    );
  }
}
