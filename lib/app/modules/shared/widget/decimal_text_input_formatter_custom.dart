import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class DecimalTextInputFormatterCustom extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatterCustom({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    /**
        double value = double.parse(newValue.text);
        final formatter = new NumberFormat("#,##0.00", "pt_BR");
        String newText = "R\$ " + formatter.format(value / 100);
        return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
     */

    var value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    var newText = formatter.format(value / 100);

    return newValue.copyWith(
      selection: TextSelection.collapsed(offset: newText.length),
      text: newText,
    );
  }
}
