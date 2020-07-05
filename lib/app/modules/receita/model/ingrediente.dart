class Ingrediente {
  String descricao;

  Ingrediente({
    this.descricao,
  });

  Ingrediente.fromMap(Map<String, dynamic> json) {
    descricao = json["descricao"];
  }

  Map<String, dynamic> toJson() {
    return {
      "descricao": descricao,
    };
  }
}
