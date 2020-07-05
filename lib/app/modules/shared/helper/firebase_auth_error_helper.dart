class FirebaseAuthErrorHelper {
  static String getError(String value) {
    if (value == null) return 'Erro ao realizar processo.';

    switch (value) {
      case 'ERROR_INVALID_EMAIL':
        return 'O email inserido não corresponde a nenhuma conta.';
      case 'ERROR_WRONG_PASSWORD':
        return 'A senha inserida está incorreta.';
      case 'ERROR_USER_NOT_FOUND':
        return 'O email inserido não corresponde a nenhuma conta.';
      case 'ERROR_USER_DISABLED':
        return 'O email inserido está inativado.';
      case 'ERROR_TOO_MANY_REQUESTS':
        return '''Muitas tentativas para esse e-mail,\n
        espere alguns minutos e tente novamente.''';
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'O email inserido está inativado.';
      case 'ERROR_WEAK_PASSWORD':
        return 'Senha fraca.';
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'O email inserido já está cadastrado.';
      default:
        print('>>>>>>>>> $value');
        return 'Erro não identificado.';
    }
  }
}
