import 'package:task_management/webservices/injector.dart';
import 'package:task_management/webservices/rest_api_client.dart';
import 'package:flutter/material.dart';

import '../../../webservices/complete_listners/base_complete_listner.dart';
import '../../../webservices/models/login_result.dart';
class SignUpRepository{
late RestApiClient restApiClient;
final BuildContext context;

SignUpRepository({required this.context}){
  restApiClient = Injector().getClient();
}

  void signUp(
      {required String username,
        required String email,
        required String password,
        required OnApiCompletion callback}) {
  callback.showLoading(context: context, isLoading: true);
    var body = {'email': email, 'username': username, 'password': password};
    restApiClient.signUp(body).then((value) {
      callback..showLoading(context: context, isLoading: false)
      ..onSuccess<LoginResult>(
          context: context, response: value, callKey: 'onSuccessSignUp');
    }).catchError((Object obj) {
      handleApiError(obj, callback, context);
    });
  }
}