import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class ByteLimitInputFormatter extends TextInputFormatter {
  final int byteLimit;

  ByteLimitInputFormatter({required this.byteLimit});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final byteLength = utf8.encode(newValue.text).length;

    if (byteLength <= byteLimit) {
      return newValue;
    }

    // Iterate over the characters in the input string
    var truncatedText = '';
    var truncatedBytes = <int>[];
    var byteCount = 0;

    for (var i = 0; i < newValue.text.length; i++) {
      var character = newValue.text[i];
      var characterBytes = utf8.encode(character);
      var characterByteLength = characterBytes.length;

      // If adding this character exceeds the byte limit, stop iterating
      if (byteCount + characterByteLength > byteLimit) {
        break;
      }

      truncatedText += character;
      truncatedBytes.addAll(characterBytes);
      byteCount += characterByteLength;
    }

    final truncatedValue = TextEditingValue(
        text: truncatedText,
        selection: newValue.selection.copyWith(
          baseOffset: min(newValue.selection.start, truncatedText.length),
          extentOffset: min(newValue.selection.end, truncatedText.length),
        ));

    return truncatedValue;
  }
}
