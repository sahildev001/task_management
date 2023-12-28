import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/add_task/bloc/add_task_cubit.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({required this.boardId,Key? key}) : super(key: key);
 final String boardId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit(context: context,boardId: boardId),
      child: _AddTaskView(),
    );
  }
}

class _AddTaskView extends StatelessWidget {
  const _AddTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddTaskCubit>(context);
    return Scaffold(
       appBar: AppBar(
         title: Text("Add Task"),
         actions: [
           TextButton(onPressed: cubit.onTapDone, child: Text("Done"))
         ],
       ),
      body: Column(
        children: [

        ],
      ),

    );
  }
}


