import 'package:intl/intl.dart';

class Util {
  static double parseStringCurrency(String value) {
    if (value != null && value.isNotEmpty) {
      var _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
      var _doubleValue = double.parse(_onlyDigits) / 100.0;
      return _doubleValue;
    }
    return 0.0;
  }

  static String parseDoubleCurrency(double value) {
    if (value != null) {
      final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
      return formatter.format(value);
    }
    return "R\$ 0,00";
  }
}
