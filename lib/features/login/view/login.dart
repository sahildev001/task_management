import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/login/repository/loginrepository.dart';
import 'package:task_management/l10n/l10n.dart';

import '../bloc/login_cubit.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          LoginCubit(context: context, repository: LoginRepository(context)),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (_,current)=> current is LoadingLoginState,
          builder: (context, state) {
            if(state is LoadingLoginState && state.isLoading){
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                const SizedBox(height: 30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: BackButton(),
                    )),
                const SizedBox(height: 30),
                _BuildSignInTitle(l10n: l10n),
                const SizedBox(
                  height: 30,
                ),
                _BuildEmailField(cubit: cubit, l10n: l10n),
                const SizedBox(
                  height: 8,
                ),
                _BuildPasswordField(
                  cubit: cubit,
                  l10n: l10n,
                ),
                const SizedBox(
                  height: 30,
                ),
                _BuildSubmitButton(
                  l10n: l10n,
                  cubit: cubit,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BuildSignInTitle extends StatelessWidget {
  _BuildSignInTitle({required this.l10n, Key? key}) : super(key: key);
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        l10n.signIn,
        style: const TextStyle(fontSize: 30, color: Colors.black),
      ),
    );
  }
}

class _BuildEmailField extends StatelessWidget {
  _BuildEmailField({required this.cubit, required this.l10n, Key? key})
      : super(key: key);
  final LoginCubit cubit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: cubit.emailController,
        focusNode: cubit.emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: l10n.email),
      ),
    );
  }
}

class _BuildPasswordField extends StatelessWidget {
  _BuildPasswordField({required this.cubit, required this.l10n, Key? key})
      : super(key: key);
  final LoginCubit cubit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (_, current) => current is ChangePasswordObscureLoginState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: cubit.passwordController,
            focusNode: cubit.passwordFocusNode,
            obscureText:
                !(state is ChangePasswordObscureLoginState && state.isVisible),
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.password,
                suffixIcon: InkWell(
                    onTap: cubit.onTapVisiblePassword,
                    child: (state is ChangePasswordObscureLoginState &&
                            state.isVisible)
                        ? Icon(Icons.visibility_sharp)
                        : Icon(Icons.visibility_off_sharp))),
          ),
        );
      },
    );
  }
}

//Build submit button
class _BuildSubmitButton extends StatelessWidget {
  _BuildSubmitButton({required this.cubit, required this.l10n, Key? key})
      : super(key: key);
  final LoginCubit cubit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: cubit.onPressSubmit,
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Text(
              l10n.continueText,
              style: TextStyle(fontSize: 18),
            )));
  }
}
