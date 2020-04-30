
import 'package:receitas/app/shareds/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class SplashController {
  final DatabaseHelper _halper;

  SplashController(this._halper);

  Future<Null> loading() async {
    await Future.delayed(Duration(seconds: 2));
    Database database = await this._halper.database;
    print("database ok!");
  }
}
