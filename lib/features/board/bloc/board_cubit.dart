import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management/features/board/models/workspace_model.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial());

  void onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = WorkSpaceModel
        .workSpaceConst.boardList[oldListIndex].taskList
        .removeAt(oldItemIndex);
    WorkSpaceModel.workSpaceConst.boardList[newListIndex].taskList
        .insert(newItemIndex, movedItem);
    emit(UpdateTaskBoardState());
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    var movedList =
        WorkSpaceModel.workSpaceConst.boardList.removeAt(oldListIndex);
    WorkSpaceModel.workSpaceConst.boardList.insert(newListIndex, movedList);
    emit(UpdateTaskBoardState());
  }
}
