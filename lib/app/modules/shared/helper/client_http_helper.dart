import 'package:dio/dio.dart';

import '../model/response_http.dart';
import 'shared_preferences_helper.dart';

class ClientHttpHelper {
  static Dio _dio;
  static ClientHttpHelper _httpHelper;
  final _tokenRequest = "6It5e4cNofGOsptCrA4M2oReYSnmEn";
  final _url = "https://receita-server-280413.rj.r.appspot.com";

  final SharedPreferencesHelper _preferencesHelper;

  factory ClientHttpHelper(_preferencesHelper) {
    _httpHelper ??= ClientHttpHelper._internalConstructor(_preferencesHelper);
    print(
      ">>>>>>>>> Iniciando Http Uma Unica Vez. ${_httpHelper.hashCode}",
    );
    _httpHelper._initDio();
    return _httpHelper;
  }

  ClientHttpHelper._internalConstructor(this._preferencesHelper);

  void _initDio() {
    if (_dio == null) _dio = Dio();
    _dio.options.baseUrl = _url;
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization-Request'] = _tokenRequest;
  }

  Future<Null> setAuthorization() async {
    try {
      var token = await _preferencesHelper.getToken();
      if (token != null) {
        _dio.options.headers['Authorization'] = token;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<Null> updateToken(Headers headers) async {
    try {
      var token = await headers.value("Authorization-Response");
      if (token != null) {
        await _preferencesHelper.setToken(token);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<ResponseHttp> post(String path, Map<String, Object> params) async {
    Response response;
    ResponseHttp responseHttp;

    await setAuthorization();

    try {
      print('[INFO]($path) >>>>> $params');
      response = await _dio.post(path, data: params);
    } on DioError catch (e) {
      response = e.response;
      print(e);
    }

    if (response != null) {
      await updateToken(response.headers);
      responseHttp = ResponseHttp.fromJson(
        response.data,
      );
    } else {
      responseHttp = ResponseHttp(
        status: 0,
        error: "SERVER_ERROR",
        message: "Servidor não está respondendo.",
      );
    }

    print(responseHttp.toJson());
    return responseHttp;
  }

  Future<ResponseHttp> get(String path) async {
    Response response;
    ResponseHttp responseHttp;

    await setAuthorization();

    try {
      print('[INFO]($path)');
      response = await _dio.get(path);
    } on DioError catch (e) {
      response = e.response;
      print(e);
    }

    if (response != null) {
      await updateToken(response.headers);
      responseHttp = ResponseHttp.fromJson(
        response.data,
      );
    } else {
      responseHttp = ResponseHttp(
        status: 0,
        error: "SERVER_ERROR",
        message: "Servidor não está respondendo.",
      );
    }

    print(responseHttp.toJson());
    return responseHttp;
  }

  Future<ResponseHttp> put(String path, Map<String, Object> params) async {
    Response response;
    ResponseHttp responseHttp;

    await setAuthorization();

    try {
      print('[INFO]($path) >>>>> $params');
      response = await _dio.put(path, data: params);
    } on DioError catch (e) {
      response = e.response;
      print(e);
    }

    if (response != null) {
      await updateToken(response.headers);
      responseHttp = ResponseHttp.fromJson(
        response.data,
      );
    } else {
      responseHttp = ResponseHttp(
        status: 0,
        error: "SERVER_ERROR",
        message: "Servidor não está respondendo.",
      );
    }

    print(responseHttp.toJson());
    return responseHttp;
  }
}
