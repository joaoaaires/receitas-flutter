import 'package:flutter/services.dart';

class DataFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = StringBuffer();
    final newTextLength = newValue.text.length;
    var usedSubstringIndex = 0;

    if (newTextLength >= 3) {
      newText.write("${newValue.text.substring(0, usedSubstringIndex = 2)}/");
    }

    if (newTextLength >= 5) {
      newText.write("${newValue.text.substring(2, usedSubstringIndex = 4)}/");
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
