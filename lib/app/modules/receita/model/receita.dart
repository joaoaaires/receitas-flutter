class Receita {
  int id;
  int idserver;
  String titulo;

  Receita({
    this.id,
    this.idserver,
    this.titulo,
  });

  Receita.fromMapSql(Map<String, dynamic> map) {
    id = map["id"];
    idserver = map["idserver"];
    titulo = map["titulo"];
  }

  Receita.fromMapHttp(Map<String, dynamic> map) {
    id = map["idPda"];
    idserver = map["id"];
    titulo = map["titulo"];
  }

  Map<String, dynamic> toJson() {
    var json = {
      "idPda": id,
      "titulo": titulo,
    };
    if (idserver != null && idserver != 0) {
      json["id"] = idserver;
    }
    return json;
  }
}
