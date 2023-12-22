import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_management/features/login/view/login.dart';
import 'package:task_management/features/signup/view/signup.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.context}) : super(AuthenticationInitial());
  final BuildContext context;
  void onTapSignin(){
    Navigator.push(context,MaterialPageRoute<Login>(builder: (_)=> const Login()));
  }

  void onTapSignUp(){
     Navigator.push(context, MaterialPageRoute<SignUp>(builder: (_)=> const SignUp()));
  }
}
