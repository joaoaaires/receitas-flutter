class Receita {
  int id;
  String titulo;

  Receita({
    this.id,
    this.titulo,
  });

  Receita.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    titulo = map["titulo"];
  }
}
