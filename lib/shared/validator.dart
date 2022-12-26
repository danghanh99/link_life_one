class Validator {
  static bool email(String input) {
    final RegExp exp = RegExp(r'.+@.+\..+$');

    return exp.hasMatch(input);
  }

  static bool onlyNumber(String input) {
    RegExp regExp = RegExp(r'^[0-9]+$');
    return regExp.hasMatch(input);
  }

  static bool onlyDouble(String input) {
    RegExp regExp = RegExp(r'^[0-9]+.[0-9]+$');
    RegExp regExp2 = RegExp(r'^[0-9]+$');
    return regExp.hasMatch(input) || regExp2.hasMatch(input);
  }

  static bool password(String input) =>
      (input.length >= 6) && !input.contains(' ');

  static bool name(String input) =>
      (input.trim().length >= 2 && input.trim().length <= 20);

  static bool naiyou(String input) => (input.trim().length >= 1);

  static bool code(String input) => (input.length > 0);

  static bool codeForgotPassword(String input) => (input.length >= 6);

  static bool nameAlbum(String input) =>
      (input.trim().length <= 0 || input.isEmpty);

  static bool thoughtFeedBack(String input) =>
      (input.trim().length <= 1 || input.isEmpty);

  static bool submitFeedBack(String input) => input.isNotEmpty;
}
