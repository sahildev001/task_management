
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/l10n/l10n.dart';
import '../bloc/authentication_cubit.dart';
class Authentication extends StatelessWidget {
  const Authentication({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=> AuthenticationCubit(context: context),
        child: const _AuthenticationView(),
    );
  }
}



class _AuthenticationView extends StatelessWidget {
  const _AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
 //------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(l10n.authenticationTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24
              ),),
            ),
SizedBox(height: 12,),
//---------------------sign up and login button
            _BuildSignUpAndLoginButton(buttonText: l10n.signUp,onPress: cubit.onTapSignUp),
            _BuildSignUpAndLoginButton(buttonText: l10n.signIn, onPress: cubit.onTapSignin),
//-------------terms of service
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
           child: RichText(
             text: TextSpan(
             children: [
               TextSpan(
                 text: '${l10n.bySigningUpText} ',

               ),
               TextSpan(
                 text: l10n.termsOfService,
                   style: const TextStyle(
                     fontWeight: FontWeight.bold,
                       decoration: TextDecoration.underline
                   )
               ),
               TextSpan(
                 text: ' ${l10n.and} ',
                   style: const TextStyle(
                       color: Colors.black
                   )
               ),
               TextSpan(
                 text: l10n.privacyPolicy,
                   style: const TextStyle(
                      fontWeight: FontWeight.bold,
                     decoration: TextDecoration.underline
                   )
               )
             ],
               style: const TextStyle(
                 fontSize: 14,
                 color: Colors.black
               ),

           ),
             textAlign: TextAlign.center,
           ),
         ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}



class _BuildSignUpAndLoginButton extends StatelessWidget {
  const _BuildSignUpAndLoginButton({required this.buttonText,required this.onPress,
    Key? key}):super(key:key);
  final String buttonText;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width*0.8,
        padding: EdgeInsets.symmetric(vertical: 13),
        margin: EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black,width: 2)
        ),
        child: Text(buttonText,
          style: TextStyle(
            fontSize: 18,
          ),),
      ),
    );
  }
}


