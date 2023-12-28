import 'package:task_management/features/board/models/task_model.dart';

import 'board_model.dart';

class WorkSpaceModel{
  String id;
  List<BoardModel> boardList;
  String workspaceName;

  WorkSpaceModel({required this.id,required this.boardList,required this.workspaceName});

  static WorkSpaceModel workSpaceConst = WorkSpaceModel(
  id: '1', boardList: [
    BoardModel(taskList: [
      TaskModel(taskName: 'task 1', taskId: '1', taskDesc: 'sample task 1'),
      TaskModel(taskName: 'task 2', taskId: '2', taskDesc: 'sample task 2'),
      TaskModel(taskName: 'task 3', taskId: '3', taskDesc: 'sample task 3'),
      TaskModel(taskName: 'task 4', taskId: '4', taskDesc: 'sample task 4'),
      TaskModel(taskName: 'task 5', taskId: '5', taskDesc: 'sample task 5'),
    ], boardId: '1', boardName: 'board 1'),
    BoardModel(taskList: [
      TaskModel(taskName: 'task 6', taskId: '6', taskDesc: 'sample task 6'),
      TaskModel(taskName: 'task 7', taskId: '7', taskDesc: 'sample task 7'),
      TaskModel(taskName: 'task 8', taskId: '8', taskDesc: 'sample task 8'),
      TaskModel(taskName: 'task 9', taskId: '9', taskDesc: 'sample task 9'),
      TaskModel(taskName: 'task 10', taskId: '10', taskDesc: 'sample task 10'),
    ], boardId: '2', boardName: 'board 2'),
    BoardModel(taskList: [
      TaskModel(taskName: 'task 11', taskId: '11', taskDesc: 'sample task 11'),
      TaskModel(taskName: 'task 12', taskId: '12', taskDesc: 'sample task 12'),
      TaskModel(taskName: 'task 13', taskId: '13', taskDesc: 'sample task 13'),
      TaskModel(taskName: 'task 14', taskId: '14', taskDesc: 'sample task 14'),
      TaskModel(taskName: 'task 15', taskId: '15', taskDesc: 'sample task 15'),
    ], boardId: '3', boardName: 'board 3'),
    BoardModel(taskList: [
      TaskModel(taskName: 'task 16', taskId: '16', taskDesc: 'sample task 16'),
      TaskModel(taskName: 'task 17', taskId: '17', taskDesc: 'sample task 17'),
      TaskModel(taskName: 'task 18', taskId: '18', taskDesc: 'sample task 18'),
      TaskModel(taskName: 'task 19', taskId: '19', taskDesc: 'sample task 19'),
      TaskModel(taskName: 'task 20', taskId: '20', taskDesc: 'sample task 20'),
    ], boardId: '4', boardName: 'board 4'),
    BoardModel(taskList: [
      TaskModel(taskName: 'task 21', taskId: '21', taskDesc: 'sample task 21'),
      TaskModel(taskName: 'task 22', taskId: '22', taskDesc: 'sample task 22'),
      TaskModel(taskName: 'task 23', taskId: '23', taskDesc: 'sample task 23'),
      TaskModel(taskName: 'task 24', taskId: '24', taskDesc: 'sample task 24'),
    ], boardId: '5', boardName: 'board 5'),
    BoardModel(taskList: [], boardId: '6', boardName: 'board 6'),
  ],
      workspaceName: 'test workspace');
}