// task_model.dart
class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});
}

// board_model.dart
class Board {
  final String id;
  final String title;
  final List<Task> tasks;

  Board({required this.id, required this.title, required this.tasks});
}