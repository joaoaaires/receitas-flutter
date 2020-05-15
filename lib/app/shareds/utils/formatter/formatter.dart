import 'package:intl/intl.dart';

class Formatter {
  static const stripRegex = r'[^\d]';

  static String formatDateQuery(String date) {
    if (date != null) {
      try {
        var dateTime = DateFormat("dd/MM/yyyy").parse(date);
        var format = DateFormat("yyyy-MM-dd").format(dateTime);
        return format;
      } on Exception catch (e) {
        print(e);
      }
    }

    return null;
  }

  static String formatDate(String date) {
    if (date != null) {
      try {
        var dateTime = DateFormat("yyyy-MM-dd").parse(date);
        var format = DateFormat("dd/MM/yyyy").format(dateTime);
        return format;
      } on Exception catch (e) {
        print(e);
      }
    }

    return null;
  }

  static String formatCelular(String value) {
    if (value != null) {
      RegExp regExp;
      value = strip(value);
      if (value.length == 10) {
        regExp = RegExp(r'^(\d{2})(\d{4})(\d{4})$');
      } else if (value.length == 11) {
        regExp = RegExp(r'^(\d{2})(\d{5})(\d{4})$');
      }
      if (regExp != null) {
        return value.replaceAllMapped(
          regExp,
          (m) => "(${m[1]}) ${m[2]}-${m[3]}",
        );
      }
    }
    return value;
  }

  static String formatCnpjCpf(String value) {
    if (value != null) {
      if (value.length == 11) {
        return formatCpf(value);
      } else if (value.length == 14) {
        return formatCnpj(value);
      }
    }
    return value;
  }

  static String formatCnpj(String cnpj) {
    var regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');
    return strip(cnpj).replaceAllMapped(
        regExp, (m) => "${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}");
  }

  static String formatCpf(String cpf) {
    var regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');
    return strip(cpf).replaceAllMapped(
        regExp, (m) => "${m[1]}.${m[2]}.${m[3]}-${m[4]}");
  }

  static String strip(String value) {
    var regex = RegExp(stripRegex);
    value = value == null ? "" : value;
    return value.replaceAll(regex, "");
  }

  static String replace(String value) {
    if (value != null) {
      value = value.replaceAll(".", "");
      value = value.replaceAll("(", "");
      value = value.replaceAll(")", "");
      value = value.replaceAll(" ", "");
      value = value.replaceAll("-", "");
      value = value.replaceAll("/", "");
      value = value.replaceAll("\\", "");
    }
    return value;
  }
}
