import 'package:receitas/app/modules/receita/model/modo_preparo.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ModoPreparoRepository {
  final DatabaseHelper _helper;

  ModoPreparoRepository(this._helper);

  Future<ModoPreparo> create(ModoPreparo modoPreparo) async {
    try {
      Database db = await this._helper.database;
      modoPreparo.id = await db.rawInsert(
        "INSERT INTO modopreparo (idreceita, descricao) VALUES (?, ?);",
        [
          modoPreparo.idreceita,
          modoPreparo.descricao,
        ],
      );
      return modoPreparo;
    } catch (e) {
      print(e);
      throw "Não é possível criar modo de preparo.";
    }
  }

}
