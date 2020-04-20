
import 'package:receitas/app/shareds/utils/formatter/formatter.dart';

class CnpjValidator {
  static const List<String> BLACKLIST = [
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
    int index = 2;

    List<int> reverse =
    cnpj.split("").map((s) => int.parse(s)).toList().reversed.toList();

    int sum = 0;

    reverse.forEach((number) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    });

    int mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  static bool isValid(String cnpj, [stripBeforeValidation = true]) {
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
    if (BLACKLIST.indexOf(cnpj) != -1) {
      return false;
    }

    String numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cnpj.substring(cnpj.length - 2);
  }

}