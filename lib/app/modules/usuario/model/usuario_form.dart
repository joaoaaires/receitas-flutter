class UsuarioForm {
  String nome;
  String email;
  String senha;

  UsuarioForm({
    this.nome,
    this.email,
    this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "email": email,
      "senha": senha,
    };
  }
}
