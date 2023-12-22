import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/signup/bloc/signup_cubit.dart';
import 'package:task_management/features/signup/repository/signup_repository.dart';

import 'package:task_management/l10n/l10n.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> SignupCubit(context: context,
          repository: SignUpRepository(
              context: context,
          ),
      ),
      child: _SignupView(),
    );
  }
}



class _SignupView extends StatelessWidget {
  const _SignupView({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignupCubit>(context);
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        body:  BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (_,current)=> current is LoadingSignUpState,
  builder: (context, state) {
            if(state is LoadingSignUpState && state.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
    return Column(
          children: [
            const SizedBox(height: 30),

         const   Align(
              alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: BackButton(),
                )),
            const SizedBox(height: 30),
            _BuildSignInTitle(l10n: l10n),
            const SizedBox(height: 30,),
            _BuildNameField(cubit: cubit,l10n: l10n),
            const SizedBox(height: 8,),
            _BuildEmailField(cubit: cubit,l10n: l10n),
            const SizedBox(height: 8,),
            _BuildPasswordField(cubit: cubit, l10n: l10n,),
            const SizedBox(height: 8,),
            _BuildConfirmPasswordField(cubit: cubit, l10n: l10n,),
            const SizedBox(height: 30,),
            _BuildSubmitButton(l10n: l10n,cubit: cubit,)
          ],
        );
  },
),
      ),
    );
  }
}


class _BuildSignInTitle extends StatelessWidget {
  _BuildSignInTitle({required this.l10n,Key? key}) :super(key: key);
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(l10n.signUp,
        style: const TextStyle(
            fontSize: 30,
            color: Colors.black
        ),),
    );
  }
}


class _BuildEmailField extends StatelessWidget {
  _BuildEmailField({required this.cubit,required this.l10n, Key? key}) :super(key: key);
  final SignupCubit cubit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: cubit.emailController,
        textInputAction: TextInputAction.next,
        focusNode: cubit.emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: l10n.email
        ),
      ),
    );
  }
}

class _BuildNameField extends StatelessWidget {
  _BuildNameField({required this.cubit,required this.l10n, Key? key}) :super(key: key);
  final SignupCubit cubit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: cubit.nameController,
        focusNode: cubit.nameFocusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.name
        ),
      ),
    );
  }
}

class _BuildPasswordField extends StatelessWidget {
  _BuildPasswordField({required this.cubit,required this.l10n, Key? key}) :super(key: key);
  final SignupCubit cubit;
  final AppLocalizations l10n;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (_,current)=> current is ChangePasswordObscureSignUpState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: cubit.passwordController,
            focusNode: cubit.passwordFocusNode,
            textInputAction: TextInputAction.next,
            obscureText: !(state is ChangePasswordObscureSignUpState && state.isVisible),
            keyboardType: TextInputType.visiblePassword,
            decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.password,
                suffixIcon: InkWell(
                    onTap: cubit.onTapVisiblePassword,
                    child: (state is ChangePasswordObscureSignUpState && state.isVisible) ? Icon(Icons.visibility_sharp): Icon(Icons.visibility_off_sharp))
            ),
          ),
        );
      },
    );
  }
}

class _BuildConfirmPasswordField extends StatelessWidget {
  _BuildConfirmPasswordField({required this.cubit,required this.l10n, Key? key}) :super(key: key);
  final SignupCubit cubit;
  final AppLocalizations l10n;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (_,current)=> current is ChangeConfirmPasswordObscureSignUpState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: cubit.confirmPasswordController,
            focusNode: cubit.confirmPasswordFocusNode,
            textInputAction: TextInputAction.done,
            obscureText: !(state is ChangeConfirmPasswordObscureSignUpState && state.isVisible),
            keyboardType: TextInputType.visiblePassword,
            decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l10n.confirmPassword,
                suffixIcon: InkWell(
                    onTap: cubit.onTapVisibleConfirmPassword,
                    child: (state is ChangeConfirmPasswordObscureSignUpState && state.isVisible) ? Icon(Icons.visibility_sharp): Icon(Icons.visibility_off_sharp))
            ),
          ),
        );
      },
    );
  }
}

//Build submit button
class _BuildSubmitButton extends StatelessWidget {
  _BuildSubmitButton({required this.cubit,required this.l10n,Key? key}):super(key:key);
  final SignupCubit cubit;
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: cubit.onPressSubmit,
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(l10n.continueText,
              style:TextStyle(
                  fontSize: 18
              ),)));
  }
}



