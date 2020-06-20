import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences _sharedPreferences;
  static SharedPreferencesHelper _sharedPreferencesHelper;

  factory SharedPreferencesHelper() {
    _sharedPreferencesHelper ??= SharedPreferencesHelper._internalConstructor();
    var hashCode = _sharedPreferencesHelper.hashCode;
    print(
      ">>>>>>>>> Iniciando Prefers Uma Unica Vez.$hashCode",
    );
    return _sharedPreferencesHelper;
  }

  SharedPreferencesHelper._internalConstructor();

  Future<Null> _loadShared() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<int> getId() async {
    await _loadShared();
    return _sharedPreferences?.getInt('id');
  }

  Future<Null> setId(int id) async {
    await _loadShared();
    await _sharedPreferences?.setInt('id', id);
  }

  Future<String> getNome() async {
    await _loadShared();
    return _sharedPreferences?.getString('nome');
  }

  Future<Null> setNome(String nome) async {
    await _loadShared();
    await _sharedPreferences?.setString('nome', nome);
  }

  Future<String> getEmail() async {
    await _loadShared();
    return _sharedPreferences?.getString('email');
  }

  Future<Null> setEmail(String email) async {
    await _loadShared();
    await _sharedPreferences?.setString('email', email);
  }

  Future<String> getToken() async {
    await _loadShared();
    return _sharedPreferences?.getString('token');
  }

  Future<Null> setToken(String token) async {
    await _loadShared();
    await _sharedPreferences?.setString('token', token);
  }

}
