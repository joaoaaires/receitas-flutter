import 'package:receitas/app/modules/receita/model/receita.dart';
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ReceitaRepository {
  final DatabaseHelper _helper;

  ReceitaRepository(this._helper);

  Future<int> create(Receita receita) async {
    try {
      Database db = await this._helper.database;
      int id = await db.rawInsert(
        "INSERT INTO receita (titulo) VALUES (?);",
        [
          receita.titulo,
        ],
      );
      return id;
    } catch (e) {
      print(e);
      throw "Não foi possível criar receita.";
    }
  }

  Future<List<Receita>> read() async {
    try {
      List<Receita> receitas = [];
      Database db = await this._helper.database;
      List<Map> result = await db.rawQuery(
        "SELECT id, titulo FROM receita ORDER BY titulo;",
      );
      result.forEach((map) {
        receitas.add(Receita.fromMap(map));
      });
      return receitas;
    } catch (e) {
      print(e);
      throw "Não foi possível recuperar receitas";
    }
  }

  Future<int> update(Receita receita) async {
    try {
      Database db = await this._helper.database;
      int count = await db.rawInsert(
        "UPDATE receita SET titulo = ? WHERE id = ?;",
        [
          receita.titulo,
          receita.id,
        ],
      );
      print("count: $count");
      return receita.id;
    } catch (e) {
      print(e);
      throw "Não foi possível criar receita.";
    }
  }

}
