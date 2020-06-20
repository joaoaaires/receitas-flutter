import '../../shared/helper/database_helper.dart';
import '../model/receita.dart';

class ReceitaRepository {
  final DatabaseHelper _helper;

  ReceitaRepository(this._helper);

  Future<int> create(Receita receita) async {
    try {
      var db = await _helper.database;
      var id = await db.rawInsert(
        "INSERT INTO receita (titulo) VALUES (?);",
        [
          receita.titulo,
        ],
      );
      return id;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível criar receita.";
    }
  }

  Future<List<Receita>> read() async {
    try {
      var receitas = <Receita>[];
      var db = await _helper.database;
      List<Map> result = await db.rawQuery(
        "SELECT id, titulo FROM receita ORDER BY titulo;",
      );
      for (var map in result) {
        receitas.add(Receita.fromMap(map));
      }
      return receitas;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível recuperar receitas";
    }
  }

  Future<List<Receita>> readByTitulo(String titulo) async {
    try {
      var receitas = <Receita>[];
      var db = await _helper.database;
      List<Map> result = await db.rawQuery(
          "SELECT id, titulo FROM receita WHERE titulo like ? ORDER BY titulo;",
          ["%$titulo%"]);
      for (var map in result) {
        receitas.add(Receita.fromMap(map));
      }
      return receitas;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível recuperar receitas";
    }
  }

  Future<Receita> readById(int id) async {
    try {
      var db = await _helper.database;
      List<Map> result = await db.rawQuery(
        "SELECT id, titulo FROM receita WHERE id = ?;",
        [
          id,
        ],
      );
      return result != null && result.isNotEmpty
          ? Receita.fromMap(result[0])
          : null;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível recuperar receitas";
    }
  }

  Future<int> update(Receita receita) async {
    try {
      var db = await _helper.database;
      await db.rawInsert(
        "UPDATE receita SET titulo = ? WHERE id = ?;",
        [
          receita.titulo,
          receita.id,
        ],
      );
      return receita.id;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível criar receita.";
    }
  }

  Future<void> delete(int id) async {
    try {
      var db = await _helper.database;
      await db.rawDelete(
        "DELETE FROM receita WHERE id = ?;",
        [id],
      );
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível deletar receita.";
    }
  }
}
