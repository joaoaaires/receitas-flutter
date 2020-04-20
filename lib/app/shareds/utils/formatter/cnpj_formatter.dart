import 'package:flutter/services.dart';

class CnpjFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    final int newTextLength = newValue.text.length;
    int usedSubstringIndex = 0;

    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ".");
    }

    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 5) + ".");
    }

    if (newTextLength >= 9) {
      newText.write(newValue.text.substring(5, usedSubstringIndex = 8) + "/");
    }

    if (newTextLength >= 13) {
      newText.write(newValue.text.substring(8, usedSubstringIndex = 12) + "-");
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
