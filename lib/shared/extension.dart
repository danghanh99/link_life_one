import 'package:intl/intl.dart';

extension IntEx on int {
  String get formatNumber {
    return NumberFormat('###,###').format(this);
  }
}

extension StringEx on String {
  String get formatNumber {
    if (isEmpty) {
      return '';
    }

    int? intNumber = int.tryParse(this);

    if (intNumber != null) {
      return NumberFormat('###,###').format(intNumber);
    }
    return '';
  }
}
