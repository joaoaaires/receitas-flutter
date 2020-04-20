import 'package:flutter/services.dart';

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    final int newTextLength = newValue.text.length;
    int usedSubstringIndex = 0;

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ".");
    }

    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + ".");
    }

    if (newTextLength >= 10) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 9) + "-");
    }

    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));

    String newTextSt = newText.toString();
    return TextEditingValue(
      selection: TextSelection.collapsed(offset: newTextSt.length),
      text: newTextSt,
    );
  }
}
