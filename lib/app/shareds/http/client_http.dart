import 'dart:convert';

import 'package:dio/dio.dart';

import 'client_response.dart';

class ClientHttp {
  final _dio = Dio();
  final _tokenRequest = "6It5e4cNofGOsptCrA4M2oReYSnmEn";
  final _url = "https://receita-server-280413.rj.r.appspot.com";

  ClientHttp() {
    _dio.options.baseUrl = _url;
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization-Request'] = _tokenRequest;
  }

  Future<Null> post(String path, Map<String, Object> params) async {
    var response;

    try {
      response = await _dio.post(path, data: params);
    } on DioError catch (e) {
      response = e.response;
      if (response == null) {
        response = Response();
//        e.message
        print(e);
      }
    }

    var clientResponse = ClientResponse.fromJson(response.data);
    print(clientResponse.status);
  }
}
