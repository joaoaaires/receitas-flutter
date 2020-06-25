import '../../shared/helper/database_helper.dart';
import '../model/ingrediente.dart';

class IngredienteRepository {
  final DatabaseHelper _helper;

  IngredienteRepository(this._helper);

  Future<int> create(Ingrediente ingrediente) async {
    try {
      var db = await _helper.database;
      var id = await db.rawInsert(
        '''
        INSERT INTO ingrediente (idserver, idreceita, descricao) VALUES (?, ?, ?);
        ''',
        [
          ingrediente.idserver,
          ingrediente.idreceita,
          ingrediente.descricao,
        ],
      );
      return id;
    } on Exception catch (e) {
      print(e);
      throw "Não é possível criar ingrediente.";
    }
  }

  Future<List<Ingrediente>> readByIdReceita(int idreceita) async {
    try {
      var db = await _helper.database;
      var ingredientes = <Ingrediente>[];
      List<Map> result = await db.rawQuery('''
          SELECT id, idserver, idreceita, descricao FROM ingrediente WHERE idreceita = ?;
          ''', [idreceita]);
      for (var map in result) {
        ingredientes.add(Ingrediente.fromMapSql(map));
      }
      return ingredientes;
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }

    Future<Ingrediente> readByIdServer(int idserver) async {
    try {
      var db = await _helper.database;
      List<Map> result = await db.rawQuery('''
          SELECT id, idserver, idreceita, descricao FROM ingrediente WHERE idserver = ?;
          ''', [idserver]);
      return result != null && result.isNotEmpty
          ? Ingrediente.fromMapSql(result[0])
          : null;
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }

  Future<int> update(Ingrediente ingrediente) async {
    try {
      var db = await _helper.database;
      await db.rawUpdate(
        '''
        UPDATE ingrediente SET idserver = ?, idreceita = ?, descricao = ? WHERE id = ?;
        ''',
        [
          ingrediente.idserver,
          ingrediente.idreceita,
          ingrediente.descricao,
          ingrediente.id,
        ],
      );
      return ingrediente.id;
    } on Exception catch (e) {
      print(e);
      throw "Não foi possível criar ingrediente.";
    }
  }

  Future<Null> delete(int id) async {
    try {
      var db = await _helper.database;
      await db.rawInsert(
        "DELETE FROM ingrediente WHERE id = ?",
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
        "DELETE FROM ingrediente WHERE idreceita = ?",
        [id],
      );
    } on Exception catch (e) {
      print(e);
      throw "Não é possível buscar ingredientes.";
    }
  }
}
