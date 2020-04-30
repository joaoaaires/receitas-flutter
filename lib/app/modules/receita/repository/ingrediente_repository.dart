import 'package:receitas/app/modules/receita/model/ingrediente.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class IngredienteRepository {
  final DatabaseHelper _helper;

  IngredienteRepository(this._helper);

  Future<Ingrediente> create(Ingrediente ingrediente) async {
    try {
      Database db = await this._helper.database;
      ingrediente.id = await db.rawInsert(
        "INSERT INTO ingrediente (idreceita, descricao) VALUES (?, ?);",
        [
          ingrediente.idreceita,
          ingrediente.descricao,
        ],
      );
      return ingrediente;
    } catch (e) {
      print(e);
      throw "Não é possível criar ingrediente.";
    }
  }

}