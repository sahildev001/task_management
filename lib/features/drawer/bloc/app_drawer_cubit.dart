import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:task_management/utils/hivePrefs/user_prefs.dart';
import 'package:flutter/material.dart';
part 'app_drawer_state.dart';


class AppDrawerCubit extends Cubit<AppDrawerState> {
  AppDrawerCubit({required this.context, required this.scaffoldKey}) : super(AppDrawerInitial());
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final UserPrefs prefs = UserPrefs();

   String? get userName => prefs.getLoginResponse()?.data?.username;
   String? get email => prefs.getLoginResponse()?.data?.email;


   void onClickLogout(){
     scaffoldKey.currentState!.closeDrawer();
   }

}
