import '../formatter/formatter.dart';

class CnpjValidator {
  static const List<String> validatorBlacklist = [
    "00000000000000",
    "11111111111111",
    "22222222222222",
    "33333333333333",
    "44444444444444",
    "55555555555555",
    "66666666666666",
    "77777777777777",
    "88888888888888",
    "99999999999999"
  ];

  // Compute the Verifier Digit (or "Dígito Verificador (DV)" in PT-BR).
  // You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
  static int _verifierDigit(String cnpj) {
    var index = 2;

    var reverse = cnpj.split("").map(int.parse).toList().reversed.toList();

    var sum = 0;

    for (var number in reverse) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    }

    var mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  static bool isValid(String cnpj, {bool stripBeforeValidation = true}) {
    if (stripBeforeValidation) {
      cnpj = Formatter.strip(cnpj);
    }

    // cnpj must be defined
    if (cnpj == null || cnpj.isEmpty) {
      return false;
    }

    // cnpj must have 14 chars
    if (cnpj.length != 14) {
      return false;
    }

    // cnpj can't be blacklisted
    if (validatorBlacklist.indexOf(cnpj) != -1) {
      return false;
    }

    var numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cnpj.substring(cnpj.length - 2);
  }
}
