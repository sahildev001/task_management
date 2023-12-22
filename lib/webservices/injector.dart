import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_management/utils/app_constants.dart';
import 'package:task_management/webservices/rest_api_client.dart';

import '../utils/hivePrefs/user_prefs.dart';
import '../utils/log.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();
  static final dio = Dio();


  factory Injector() {

    return _singleton;
  }

  Injector._internal();

  RestApiClient getClient() {
    // dio.options.connectTimeout = 10000;
    // dio.options.receiveTimeout = 3000;
   // dio.options.baseUrl = ApiService.baseurl;
    dio.options.followRedirects = false;
    dio.options.headers["Content-Type"] = "application/json";
    var token =  UserPrefs().getString(AppConstants.token);
    if (token != "") {
      Log.printInfo(filename: "injector:: ", info: "token=" + token);
      dio.options.headers["Authorization"] = token;
      dio.options.headers["Content-Type"] = "application/json";
    }
    dio.interceptors.clear();

    dio.interceptors.add(new LoggingInterceptors());
    final client = RestApiClient(dio);
    return client;
  }
}

class LoggingInterceptors extends Interceptor {



  LoggingInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.printInfo(filename: "injector:: ", info :'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}');
    options.headers.forEach((k, v) =>  Log.printInfo(filename: "injector:: ", info :'$k: $v'));
    Log.printInfo(filename: "injector:: ", info : "queryParameters:");
    options.queryParameters.forEach((k, v) =>  Log.printInfo(filename: "injector:: ", info :'$k: $v',));
    if (options.data != null) {
      Log.printInfo(filename: "injector:: ", info:"Body: ${options.data}");
    }



    Log.printInfo(filename: "injector:: ", info:
    "--> END ${options.method != null? options.method.toUpperCase() : 'METHOD'}",);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.printInfo(filename: "injector::  ", info:
    'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    Log.printInfo(filename: "injector:: ", info:"Headers:");
    response.headers.forEach((k, v) =>  Log.printInfo(filename: "injector:: ", info:'$k: $v',));
    Log.printInfo(filename: "injector:: ", info:"Response: ${jsonEncode(response.data)}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.printError(filename: "injector:: ", error:
    'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}  message ${err.message}');




    return super.onError(err, handler);
  }
}
