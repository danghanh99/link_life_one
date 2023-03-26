class PersonModel {
  String tantCode;
  String tantName;
  String tantKbnCode;

  PersonModel(
      {required this.tantCode,
      required this.tantName,
      required this.tantKbnCode});

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
      tantCode: json['TANT_CD'] ?? '',
      tantName: json['TANT_NAME'] ?? '',
      tantKbnCode: json['TANT_KBN_CD'] ?? '');
}
