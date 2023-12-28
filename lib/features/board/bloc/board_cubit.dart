import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/features/add_task/view/add_task.dart';
import 'package:task_management/features/board/models/task_model.dart';
import 'package:task_management/features/board/models/workspace_model.dart';
import 'package:task_management/utils/log.dart';

import '../models/board_model.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit({required this.context}) : super(BoardInitial());
  List<BoardModel> boardList = [];
  final BuildContext context;

  void init() {
    boardList = WorkSpaceModel.workSpaceConst.boardList.map((e) {
      final model = TaskModel(
          taskName: '', taskId: 'addId', taskDesc: '', isAddItem: true);
      if (!e.taskList.contains(model)) {
        e.taskList.add(model);
      }
      return e;
    }).toList();
    final boardAddModel = BoardModel(
        taskList: [], boardId: 'addId', boardName: '', isAddItem: true);
    if (!boardList.contains(boardAddModel)) {
      boardList.add(boardAddModel);
    }

    emit(UpdateTaskBoardState());
  }

  void onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    if (boardList[newListIndex].isAddItem) {
      return;
    }
    Log.printInfo(
        filename: 'board_cubit.dart',
        info:
            'value on task list : ${boardList[newListIndex].taskList.length} ,  new index ${newItemIndex}');
    if ((boardList[newListIndex].taskList.length == newItemIndex) ||
        (boardList[newListIndex].taskList.length - 1 == newItemIndex)) {
      final movedItem = boardList[oldListIndex].taskList.removeAt(oldItemIndex);
      boardList[newListIndex].taskList.insert(newItemIndex - 1, movedItem);
    } else {
      final movedItem = boardList[oldListIndex].taskList.removeAt(oldItemIndex);
      boardList[newListIndex].taskList.insert(newItemIndex, movedItem);
    }

    emit(UpdateTaskBoardState());
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    if (boardList.length - 1 == newListIndex) {
      final movedList = boardList.removeAt(oldListIndex);
      boardList.insert(newListIndex - 1, movedList);
    } else {
      final movedList = boardList.removeAt(oldListIndex);
      boardList.insert(newListIndex, movedList);
    }
    emit(UpdateTaskBoardState());
  }

  void onTapAddCard(String boardId) async{
    final result = await Navigator.push(context, MaterialPageRoute<AddTaskPage>(builder: (_)=> AddTaskPage(boardId: boardId,)));

  }
}
