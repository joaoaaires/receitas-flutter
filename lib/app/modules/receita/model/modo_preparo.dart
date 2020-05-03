class ModoPreparo {
  int id;
  int idreceita;
  String descricao;

  ModoPreparo({
    this.id,
    this.idreceita,
    this.descricao,
  });

  ModoPreparo.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    idreceita = map["idreceita"];
    descricao = map["descricao"];
  }
}
