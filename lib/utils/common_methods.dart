import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class CommonMethods{

  static void showMessage({required BuildContext context, required String message}){
    showToast(message,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration:const  Duration(seconds: 1),
      duration: const Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      dismissOtherToast: true,
      alignment: Alignment.bottomLeft,

    );
  }
}