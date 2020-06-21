class ModoPreparo {
  int id;
  String descricao;

  ModoPreparo({
    this.id,
    this.descricao,
  });

  ModoPreparo.fromMap(Map<String, dynamic> map) {
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
