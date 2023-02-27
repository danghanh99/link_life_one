import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Kiểm tra nếu giá trị mới không phải là số
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == '-') {
      return newValue.copyWith(text: '-');
    } else if (newValue.text.contains(',')) {
      // Nếu giá trị mới đã có dấu phẩy thì bỏ qua định dạng
      return oldValue;
    }

    // Chuyển đổi giá trị mới sang kiểu số
    int value = int.tryParse(newValue.text.replaceAll(',', '')) ?? 0;

    // Định dạng giá trị mới
    String formattedValue = _formatter.format(value);

    // Trả về giá trị mới đã được định dạng
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
