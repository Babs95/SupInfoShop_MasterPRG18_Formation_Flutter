import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../api/restClient.dart';

class Config {
  static String? baseUrl;
  static Dio? dio;
  static RestClient? restClient;

  static const String BASE_URL = "http://10.0.2.2:8000";

  Future<void> init(BuildContext ctx) async {
    if(dio != null){
      dio?.interceptors.clear();
    }
    dio = getDio();
    restClient =  RestClient(dio!);
    baseUrl = BASE_URL;
  }

  static Dio getDio({String? token}) {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    );

    if(token != null && token.isNotEmpty){
      options.headers["authorization"] = "Bearer $token";
    }

    options.headers['accept'] = "application/json";
    return Dio(options);
  }
}