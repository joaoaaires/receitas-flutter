import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class IngredienteRepository {
  final DatabaseHelper _helper;

  IngredienteRepository(this._helper);

  Future<int> create(Ingrediente ingrediente) async {
    try {
      Database db = await this._helper.database;
      int id = await db.rawInsert(
        "INSERT INTO ingrediente (idreceita, descricao) VALUES (?, ?);",
        [
          ingrediente.idreceita,
          ingrediente.descricao,
        ],
      );
      return id;
    } catch (e) {
      print(e);
      throw "Não é possível criar ingrediente.";
    }
  }

  Future<List<Ingrediente>> readByIdReceita(int idreceita) async {
    try {
      List<Ingrediente> ingredientes = [];
      Database db = await this._helper.database;
      List<Map> result = await db.rawQuery(
          "SELECT id, idreceita, descricao FROM ingrediente WHERE idreceita = ?;",
          [idreceita]);
      result.forEach((map) {
        ingredientes.add(Ingrediente.fromMap(map));
      });
      return ingredientes;
    } catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }

  //update

  Future<Null> delete(int id) async {
    try {
      Database db = await this._helper.database;
      await db.rawInsert(
        "DELETE FROM ingrediente WHERE id = ?",
        [id],
      );
    } catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }
}
