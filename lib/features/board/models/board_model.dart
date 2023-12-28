import 'task_model.dart';
class BoardModel{
  List<TaskModel> taskList;
  String boardId;
  String boardName;
  bool isAddItem;

  BoardModel({required this.taskList,required this.boardId,required this.boardName, this.isAddItem = false});

  @override
  int get hashCode => boardId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BoardModel && runtimeType == other.runtimeType && boardId == other.boardId;

}


