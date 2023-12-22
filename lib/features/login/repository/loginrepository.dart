import 'package:task_management/webservices/complete_listners/base_complete_listner.dart';
import 'package:task_management/webservices/models/login_result.dart';

import '../../../webservices/injector.dart';
import 'package:flutter/material.dart';
import 'package:task_management/webservices/rest_api_client.dart';

class LoginRepository {
  late RestApiClient restApiClient;
  final BuildContext context;

  LoginRepository(this.context) {
    restApiClient = Injector().getClient();
  }

  void signin(
      {required String email,
      required String password,
      required OnApiCompletion callback}) {
    callback.showLoading(context: context, isLoading: true);
    var body = {'email': email, 'password': password};
    restApiClient.login(body).then((value) {
      callback.showLoading(context: context, isLoading: false);

      callback.onSuccess<LoginResult>(
          context: context, response: value, callKey: 'onSuccessLogin');
    }).catchError((Object obj) {
      handleApiError(obj, callback, context);
    });
  }


}
