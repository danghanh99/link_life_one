class People {
  final String tantoName;
  final String tantoCd;

  People({
    required this.tantoName,
    required this.tantoCd,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      tantoName: json["TANT_NAME"],
      tantoCd: json["TANT_CD"],
    );
  }
}
