part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {
 final bool isLoading;

 LoadingLoginState({required this.isLoading});
}

class ChangePasswordObscureLoginState extends LoginState {

 ChangePasswordObscureLoginState(this.isVisible);
 final bool isVisible;
}



