import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/board/view/board.dart';
import 'package:task_management/features/drawer/bloc/app_drawer_cubit.dart';
import 'package:task_management/features/home/bloc/home_cubit.dart';

import '../../drawer/view/app_drawer.dart';


class Home extends StatelessWidget {
   Home({Key? key}) :super(key: key);
 final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit(context: context)),
        BlocProvider(create: (_) => AppDrawerCubit(
          context: context,
          scaffoldKey:  scaffoldKey,
        ),
        ),
      ],
      child:  _HomeView(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.scaffoldKey, super.key});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Board'),
      ),
      drawer: AppDrawer(),
      body: BoardPage(),
    );
  }
}

