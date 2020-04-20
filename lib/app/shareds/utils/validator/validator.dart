import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receitas/app/shareds/utils/validator/cnpj_validator.dart';
import 'package:receitas/app/shareds/utils/validator/cpf_validator.dart';
import 'package:validators/validators.dart';

class Validator {
  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator required({
    String errorText = "Campo obrigatório",
  }) {
    return (valueCandidate) {
      if (valueCandidate == null ||
          ((valueCandidate is Iterable ||
              valueCandidate is String ||
              valueCandidate is Map) &&
              valueCandidate.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator cpfValid() {
    return (valueCandidate) {
      if (valueCandidate != null && !CpfValidator.isValid(valueCandidate)) {
        return "CPF inválido";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field have a non-empty value.
  static FormFieldValidator cnpjValid() {
    return (valueCandidate) {
      if (valueCandidate != null && !CnpjValidator.isValid(valueCandidate)) {
        return "CNPJ inválido";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be true.
  /// Commonly used for required checkboxes.
  static FormFieldValidator requiredTrue({
    String errorText = "Este campo deve ser marcado",
  }) {
    return (valueCandidate) {
      if (valueCandidate != true) {
        return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be greater than
  /// or equal to the provided number.
  static FormFieldValidator min(
      num min, {
        String errorText,
      }) {
    return (valueCandidate) {
      if (valueCandidate != null &&
          ((valueCandidate is num && valueCandidate < min) ||
              (valueCandidate is String &&
                  num.tryParse(valueCandidate) != null &&
                  num.tryParse(valueCandidate) < min))) {
        return errorText ?? "Deve ser maior ou igual a $min";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be less than
  /// or equal to the provided number.
  static FormFieldValidator max(
      num max, {
        String errorText,
      }) {
    return (valueCandidate) {
      if (valueCandidate != null) {
        if ((valueCandidate is num && valueCandidate > max) ||
            (valueCandidate is String &&
                num.tryParse(valueCandidate) != null &&
                num.tryParse(valueCandidate) > max)) {
          return errorText ?? "Deve ser menor ou igual a $max";
        }
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// greater than or equal to the provided minimum length.
  static FormFieldValidator minLength(
      num minLength, {
        String errorText,
      }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.length < minLength) {
        return errorText ?? "Deve ter pelo menos $minLength caracteres";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the length of the field's value to be
  /// less than or equal to the provided maximum length.
  static FormFieldValidator maxLength(
      num maxLength, {
        String errorText,
      }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.length > maxLength) {
        return errorText ?? "Deve ter no máximo $maxLength caracteres";
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator email({
    String errorText = "E-mail inválido",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isEmail(valueCandidate)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid url.
  static FormFieldValidator url(
      {String errorText = "URL inválida",
        List<String> protocols = const ['http', 'https', 'ftp'],
        bool requireTld = true,
        bool requireProtocol = false,
        bool allowUnderscore = false,
        List<String> hostWhitelist = const [],
        List<String> hostBlacklist = const []}) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isURL(valueCandidate,
            protocols: protocols,
            requireTld: requireTld,
            requireProtocol: requireProtocol,
            allowUnderscore: allowUnderscore,
            hostWhitelist: hostWhitelist,
            hostBlacklist: hostBlacklist)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to match a regex
  /// pattern.
  static FormFieldValidator pattern(
      Pattern pattern, {
        String errorText = "O valor está fora do padrão necessário",
      }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!RegExp(pattern).hasMatch(valueCandidate)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid number.
  static FormFieldValidator numeric({
    String errorText = "Apenas números",
  }) {
    return (valueCandidate) {
      if (num.tryParse(valueCandidate) == null && valueCandidate.isNotEmpty)
        return errorText;
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid credit card number.
  static FormFieldValidator creditCard({
    String errorText = "Número de cartão de crédito inválido",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isCreditCard(valueCandidate)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid credit vencimento card number.
  static String creditCardMonthYear(
      String month,
      String year, {
        String errorText = "Cartão de crédito vencido.",
      }) {
    bool hasValue = year != null && year.isNotEmpty && month != null && month.isNotEmpty;
    if (!hasValue) return null;

    int yearCard = int.parse("$year");
    int monthCard = int.parse("$month");

    DateTime dateTimeAtual = DateTime.now();

    int monthAtual = dateTimeAtual.month;
    List<String> yearArray = "${dateTimeAtual.year}".split("");
    int yearAtual = int.parse("${yearArray[2]}${yearArray[3]}");

    if (yearCard < yearAtual) {
      return errorText;
    } else if (yearCard == yearAtual) {
      if (monthCard < monthAtual) {
        return errorText;
      }
    }
    return null;
  }

  /// [FormFieldValidator] that requires the field's value to be a valid IP.
  // ignore: non_constant_identifier_names
  static FormFieldValidator IP({
    dynamic version,
    String errorText = "IP inválido",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (!isIP(valueCandidate, version)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator date({
    String errorText = "Data inválida",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        if (valueCandidate.contains("/")) {
          String dateFormat;
          try {
            DateTime dateTime = DateFormat("dd/MM/yyyy").parse(valueCandidate);
            if (valueCandidate != DateFormat("dd/MM/yyyy").format(dateTime))
              return errorText;

            if (dateTime.year < 1900) return errorText;

            String format = DateFormat("yyyy-MM-dd").format(dateTime);
            dateFormat = format;
          } catch (e) {}

          if (dateFormat != null) {
            valueCandidate = dateFormat;
          } else {
            return null;
          }
        }

        if (!isDate(valueCandidate)) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value to be a valid date string.
  static FormFieldValidator month({
    String errorText = "Mês inválido",
  }) {
    return (valueCandidate) {
      if (valueCandidate != null && valueCandidate.isNotEmpty) {
        DateTime now = DateTime.now();
        int month = int.parse(valueCandidate);

        DateTime nowNewMonth = DateTime(now.year, month, now.day);
        if (nowNewMonth.month != month) return errorText;
      }
      return null;
    };
  }

  /// [FormFieldValidator] that requires the field's value be true.
  /// Commonly used for required checkboxes.
  static FormFieldValidator requiredOld() {
    return (valueCandidate) {
      String error = date()(valueCandidate);
      if (error != null) return error;

      DateTime dateTime = DateFormat("dd/MM/yyyy").parse(valueCandidate);
      DateTime now = DateTime.now();

      int totalDays = now.difference(dateTime).inDays;
      int totalDays18 = (365.25 * 18).toInt();

      if (totalDays < totalDays18) return "Idade mínima é 18 anos";

      return null;
    };
  }
}
