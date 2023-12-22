part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class LoadingSignUpState extends SignupState {
  final bool isLoading;

  LoadingSignUpState({required this.isLoading});
}

class ChangePasswordObscureSignUpState extends SignupState {

  ChangePasswordObscureSignUpState(this.isVisible);
  final bool isVisible;
}
class ChangeConfirmPasswordObscureSignUpState extends SignupState {

  ChangeConfirmPasswordObscureSignUpState(this.isVisible);
  final bool isVisible;
}

