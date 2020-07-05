class ModoPreparo {
  String descricao;

  ModoPreparo({
    this.descricao,
  });

  ModoPreparo.fromMap(Map<String, dynamic> json) {
    descricao = json["descricao"];
  }

  Map<String, dynamic> toJson() {
    return {
      "descricao": descricao,
    };
  }
}
