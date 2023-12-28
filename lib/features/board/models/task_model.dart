class TaskModel{
  String taskName;
  String taskId;
  String taskDesc;
  bool isAddItem;

  TaskModel({required this.taskName,required this.taskId,required this.taskDesc, this.isAddItem = false});

  @override
  int get hashCode => taskId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskModel && runtimeType == other.runtimeType && taskId == other.taskId;

}