import '../../shareds/utils/database_helper.dart';

class SplashController {
  final DatabaseHelper _halper;

  SplashController(this._halper);

  Future<Null> loading() async {
    await Future.delayed(Duration(seconds: 2));
    var database = await _halper.database;
    print("database ok! ${database != null}");
  }
}
