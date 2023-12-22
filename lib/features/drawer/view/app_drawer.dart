import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/drawer/bloc/app_drawer_cubit.dart';
import 'package:task_management/l10n/l10n.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = BlocProvider.of<AppDrawerCubit>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _BuildDrawerHeader(cubit: cubit),
          ListTile(
            title: Text("Boards"),
            onTap: (){

            },
          )
        ],
      ),
    );
  }
}

class _BuildDrawerHeader extends StatelessWidget {
  const _BuildDrawerHeader({required this.cubit, super.key});
  final AppDrawerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  cubit.userName.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  cubit.email.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: cubit.onClickLogout,
            icon: const Icon(
              Icons.logout_outlined,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
