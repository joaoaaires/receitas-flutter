class UsuarioResponse {
  int id;
  String nome;
  String email;

  UsuarioResponse({
    this.id,
    this.nome,
    this.email,
  });

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioResponse(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
    );
  }
}
