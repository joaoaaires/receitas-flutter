class UsuarioForm {
  String email;
  String senha;

  UsuarioForm({
    this.email,
    this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "senha": senha,
    };
  }
}
