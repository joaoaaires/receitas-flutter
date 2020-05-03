import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ModoPreparoRepository {
  final DatabaseHelper _helper;

  ModoPreparoRepository(this._helper);

  Future<int> create(ModoPreparo modoPreparo) async {
    try {
      Database db = await this._helper.database;
      int id = await db.rawInsert(
        "INSERT INTO modopreparo (idreceita, descricao) VALUES (?, ?);",
        [
          modoPreparo.idreceita,
          modoPreparo.descricao,
        ],
      );
      return id;
    } catch (e) {
      print(e);
      throw "Não é possível criar modo de preparo.";
    }
  }

  Future<List<ModoPreparo>> readByIdReceita(int idreceita) async {
    try {
      List<ModoPreparo> modosPreparo = [];
      Database db = await this._helper.database;
      List<Map> result = await db.rawQuery(
          "SELECT id, idreceita, descricao FROM modopreparo WHERE idreceita = ?;",
          [idreceita]);
      result.forEach((map) {
        modosPreparo.add(ModoPreparo.fromMap(map));
      });
      return modosPreparo;
    } catch (e) {
      print(e);
      throw "Não é possível buscar modos de preparo.";
    }
  }

  //update

  Future<Null> delete(int id) async {
    try {
      Database db = await this._helper.database;
      await db.rawInsert(
        "DELETE FROM modopreparo WHERE id = ?",
        [id],
      );
    } catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }
}
