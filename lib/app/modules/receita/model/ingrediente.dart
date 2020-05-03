class Ingrediente {
  int id;
  int idreceita;
  String descricao;

  Ingrediente({
    this.id,
    this.idreceita,
    this.descricao,
  });

  Ingrediente.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    idreceita = map["idreceita"];
    descricao = map["descricao"];
  }
}
