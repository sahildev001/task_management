import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit({required this.context,required this.boardId}) : super(AddTaskInitial());
  final BuildContext context;
    final String boardId;

  void onTapDone() {
  }
}
