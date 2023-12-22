import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/drawer/bloc/app_drawer_cubit.dart';
import 'package:task_management/features/home/bloc/home_cubit.dart';

import '../../drawer/view/app_drawer.dart';
import '../models/board_model.dart';


class Home extends StatelessWidget {
   Home({Key? key}) :super(key: key);
 final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit(context: context)),
        BlocProvider(create: (_) => AppDrawerCubit(
          context: context,
          scaffoldKey:  scaffoldKey,
        ),
        ),
      ],
      child:  _HomeView(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.scaffoldKey, super.key});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Board'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskList(
              title: "Column 1",
              tasks: [
                Task(id: "1", title: "task 1"),
                Task(id: "2", title: "task 2"),
                Task(id: "3", title: "task 3"),
                Task(id: "4", title: "task 4"),
              ],
            ),
            SizedBox(width: 10,),
            TaskList(
              title: 'Column 2',
              tasks: [
                Task(id: "5", title: "task 5"),
                Task(id: "6", title: "task 6"),
                Task(id: "7", title: "task 7"),
                Task(id: "8", title: "task 8"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final String title;
  final List<Task> tasks;

  TaskList({required this.title, required this.tasks});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Set a fixed width for the TaskList
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ReorderableListView(
                  padding: EdgeInsets.only(top: 8.0),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final Task task = widget.tasks.removeAt(oldIndex);
                      widget.tasks.insert(newIndex, task);
                    });
                  },
                  children: widget.tasks
                      .map((task) => TaskItem(key: ValueKey(task.id), task: task))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required Key key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<Task>(
      data: task,
      feedback: _buildDraggableFeedback(context),
      child: _buildTaskItem(context),
      childWhenDragging: Container(), // Placeholder when dragging
    );
  }

  Widget _buildDraggableFeedback(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(task.title),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context) {
    return Card(
      key: ValueKey(task.id),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(task.title),
      ),
    );
  }
}

