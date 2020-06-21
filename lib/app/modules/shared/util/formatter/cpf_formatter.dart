import 'package:flutter/services.dart';

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = StringBuffer();
    final newTextLength = newValue.text.length;
    var usedSubstringIndex = 0;

    if (newTextLength >= 4) {
      newText.write("${newValue.text.substring(0, usedSubstringIndex = 3)}.");
    }

    if (newTextLength >= 7) {
      newText.write("${newValue.text.substring(3, usedSubstringIndex = 6)}.");
    }

    if (newTextLength >= 10) {
      newText.write("${newValue.text.substring(6, usedSubstringIndex = 9)}-");
    }

    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    var newTextSt = newText.toString();
    return TextEditingValue(
      selection: TextSelection.collapsed(offset: newTextSt.length),
      text: newTextSt,
    );
  }
}
