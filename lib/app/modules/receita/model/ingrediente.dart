class Ingrediente {
  int id;
  int idserver;
  int idreceita;
  String descricao;

  Ingrediente({
    this.id,
    this.idserver,
    this.idreceita,
    this.descricao,
  });

  Ingrediente.fromMapSql(Map<String, dynamic> map) {
    id = map["id"];
    idserver = map["idserver"];
    descricao = map["descricao"];
  }

  Ingrediente.fromMapHttp(Map<String, dynamic> map) {
    id = map["idPda"];
    idserver = map["id"];
    descricao = map["descricao"];
  }

  Map<String, dynamic> toJson() {
    var json = {
      "idPda": id,
      "descricao": descricao,
    };
    if (idserver != null && idserver != 0) {
      json["id"] = idserver;
    }
    return json;
  }

}
