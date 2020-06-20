import '../../shared/helper/database_helper.dart';
import '../model/modo_preparo.dart';

class ModoPreparoRepository {
  final DatabaseHelper _helper;

  ModoPreparoRepository(this._helper);

  Future<int> create(ModoPreparo modoPreparo) async {
    try {
      var db = await _helper.database;
      var id = await db.rawInsert(
        "INSERT INTO modopreparo (idreceita, descricao) VALUES (?, ?);",
        [
          modoPreparo.idreceita,
          modoPreparo.descricao,
        ],
      );
      return id;
    } on Exception catch (e) {
      print(e);
      throw "Não é possível criar modo de preparo.";
    }
  }

  Future<List<ModoPreparo>> readByIdReceita(int idreceita) async {
    try {
      var modosPreparo = <ModoPreparo>[];
      var db = await _helper.database;
      List<Map> result = await db.rawQuery('''
          SELECT id, idreceita, descricao FROM modopreparo WHERE idreceita = ?;
          ''', [idreceita]);
      for (var map in result) {
        modosPreparo.add(ModoPreparo.fromMap(map));
      }
      return modosPreparo;
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar modos de preparo.";
    }
  }

  //update

  Future<Null> delete(int id) async {
    try {
      var db = await _helper.database;
      await db.rawInsert(
        "DELETE FROM modopreparo WHERE id = ?",
        [id],
      );
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }

  Future<Null> deleteByIdReceita(int id) async {
    try {
      var db = await _helper.database;
      await db.rawInsert(
        "DELETE FROM modopreparo WHERE idreceita = ?",
        [id],
      );
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }
}
