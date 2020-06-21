class Ingrediente {
  int id;
  String descricao;

  Ingrediente({
    this.id,
    this.descricao,
  });

  Ingrediente.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    descricao = map["descricao"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "descricao": descricao,
    };
  }

}
