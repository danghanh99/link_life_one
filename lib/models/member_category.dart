class MemberCategory {
  String? kbnCode;
  String? kbnmsaiName;

  MemberCategory({this.kbnCode, this.kbnmsaiName});

  factory MemberCategory.fromJson(Map<String, dynamic> json) => MemberCategory(
      kbnCode: json['KBNMSAI_CD'] ?? '', kbnmsaiName: json['KBNMSAI_NAME'] ?? '');
}
