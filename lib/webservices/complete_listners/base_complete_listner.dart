
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../utils/log.dart';


 mixin OnApiCompletion {
  void error(String error,{String? callKey});
  void showLoading({required BuildContext context, required bool isLoading, Map<String,dynamic>? args});
  void sessionExpire({required BuildContext context}){

  }
  void onSuccess<T>({required BuildContext context, required T response, required String callKey, Map<String,dynamic>? args});
}


void handleApiError(Object obj, OnApiCompletion callback, BuildContext context,{bool handleLoading = true, bool showMessages = true}) {
  if(handleLoading) {
    callback.showLoading(context: context, isLoading: false);
  }
  Log.printError(error: obj,filename: "api: ");
  switch (obj.runtimeType) {
    case DioException:
      final res = (obj as DioException).response;
      if (res != null) {
       var message = (res.data);
        Log.printError(error: "Got error : ${res.statusCode} -> ${message["message"]}", filename: "api: ");
      if(showMessages)  callback.error(message["message"].toString());
      }else if ( res?.statusCode == 401){
        if(showMessages)   callback.sessionExpire(context: context);
     } else{
        if(showMessages)   callback.error("Connection error");
      }
      break;
    default:
      if(showMessages)  callback.error("Connection error");
  }
}

