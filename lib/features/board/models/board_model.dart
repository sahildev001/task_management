import 'task_model.dart';
class BoardModel{
  List<TaskModel> taskList;
  String boardId;
  String boardName;

  BoardModel({required this.taskList,required this.boardId,required this.boardName});
}


