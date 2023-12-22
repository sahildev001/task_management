import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:task_management/features/signup/repository/signup_repository.dart';
import 'package:task_management/utils/common_methods.dart';
import 'package:task_management/utils/extentions.dart';
import 'package:task_management/utils/hivePrefs/user_prefs.dart';
import 'package:task_management/webservices/complete_listners/base_complete_listner.dart';

import '../../../utils/app_constants.dart';
import '../../../webservices/models/login_result.dart';
import '../../home/view/home.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> with OnApiCompletion {
  SignupCubit({required this.context, required this.repository})
      : super(SignupInitial());
  final BuildContext context;
  final SignUpRepository repository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  bool visiblePassword = false;
  final UserPrefs prefs = UserPrefs();

  void onTapVisiblePassword() {
    visiblePassword = !visiblePassword;
    emit(ChangePasswordObscureSignUpState(visiblePassword));
  }

  void onTapVisibleConfirmPassword() {
    visiblePassword = !visiblePassword;
    emit(ChangeConfirmPasswordObscureSignUpState(visiblePassword));
  }

  void onPressSubmit() {
    if (validateData()) {
      repository.signUp(
          username: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          callback: this);
    }
  }

  bool validateData() {
    if (isClosed) {
      return false;
    }
    if (nameController.text.isEmpty) {
      CommonMethods.showMessage(context: context, message: 'Enter name');
      nameFocusNode.requestFocus();
      return false;
    } else if (emailController.text.isEmpty) {
      CommonMethods.showMessage(context: context, message: 'Enter email');
      emailFocusNode.requestFocus();
      return false;
    } else if (!emailController.text.isValidEmail()) {
      CommonMethods.showMessage(context: context, message: 'Enter valid email');
      emailFocusNode.requestFocus();
      return false;
    } else if (passwordController.text.isEmpty) {
      CommonMethods.showMessage(context: context, message: 'Enter password');
      passwordFocusNode.requestFocus();
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      CommonMethods.showMessage(
          context: context, message: 'Enter confirm password');
      confirmPasswordFocusNode.requestFocus();
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      CommonMethods.showMessage(
          context: context,
          message: "Password and confirm password didn't match");
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
      prefs..setString(AppConstants.token, response.token ?? '')
      ..setLoginResponse(loginResult: response);
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<Home>(builder: (_) =>  Home()),
        (route) => false,
      );
    }
  }

  @override
  void showLoading(
      {required BuildContext context,
      required bool isLoading,
      Map<String, dynamic>? args}) {
    emit(LoadingSignUpState(isLoading: isLoading));
  }
}
