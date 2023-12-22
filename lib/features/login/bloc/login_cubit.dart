import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_management/features/login/repository/loginrepository.dart';
import 'package:task_management/utils/app_constants.dart';
import 'package:task_management/utils/hivePrefs/user_prefs.dart';
import 'package:task_management/webservices/complete_listners/base_complete_listner.dart';
import 'package:task_management/webservices/models/login_result.dart';

import '../../../utils/common_methods.dart';
import '../../home/view/home.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with OnApiCompletion {
  LoginCubit({required this.context, required this.repository})
      : super(LoginInitial());
  final LoginRepository repository;
  final BuildContext context;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool visiblePassword = false;
  final UserPrefs prefs = UserPrefs();

  void onTapVisiblePassword() {
    visiblePassword = !visiblePassword;
    emit(ChangePasswordObscureLoginState(visiblePassword));
  }

  void onPressSubmit() {
    if (validateData()) {
      repository.signin(
          email: emailController.text,
          password: passwordController.text,
          callback: this);
    }
  }

  bool validateData() {
    if (isClosed) {
      return false;
    }
    if (emailController.text.isEmpty) {
      CommonMethods.showMessage(context: context, message: 'Enter email');
      emailFocusNode.requestFocus();
      return false;
    } else if (passwordController.text.isEmpty) {
      CommonMethods.showMessage(context: context, message: 'Enter password');
      passwordFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  @override
  void error(String error, {String? callKey}) {
    CommonMethods.showMessage(context: context, message: error);
    showLoading(context: context, isLoading: false);
  }

  @override
  void onSuccess<T>(
      {required BuildContext context,
      required T response,
      required String callKey,
      Map<String, dynamic>? args}) {
    if (response is LoginResult) {
      prefs
        ..setString(AppConstants.token, response.token ?? '')
        ..setLoginResponse(loginResult: response);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<Home>(builder: (_) =>  Home()),
          (route) => false,);
    }
  }

  @override
  void showLoading(
      {required BuildContext context,
      required bool isLoading,
      Map<String, dynamic>? args}) {
    emit(LoadingLoginState(isLoading: isLoading));
  }
}
