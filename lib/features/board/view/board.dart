import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/board/bloc/board_cubit.dart';
import 'package:task_management/features/board/models/task_model.dart';
import 'package:task_management/features/board/models/workspace_model.dart';

import '../models/board_model.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BoardCubit(),
      child: _BoardView(),
    );
  }
}

class _BoardView extends StatelessWidget {
  _BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BoardCubit>(context);
    return Scaffold(
      appBar:  AppBar(
        title:  Text(WorkSpaceModel.workSpaceConst.workspaceName),
      ),
      body: BlocBuilder<BoardCubit, BoardState>(
        buildWhen: (_,current)=> current is UpdateTaskBoardState,
  builder: (context, state) {
    return DragAndDropLists(
        children:  _buildList(context),
        onItemReorder: cubit.onItemReorder,
        onListReorder: cubit.onListReorder,
        axis: Axis.horizontal,
        listWidth: 150,
        listDraggingWidth: 150,
        listDecoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 3.0,
              blurRadius: 6.0,
              offset: Offset(2, 3),
            ),
          ],
        ),
        listPadding: const EdgeInsets.all(8.0),
      );
  },
),
    );
  }


 List<DragAndDropList> _buildList(BuildContext context) {
   List<BoardModel> contentList = WorkSpaceModel.workSpaceConst.boardList;
   return contentList.map((e) {
     return  DragAndDropList(
       header: Row(
         children: <Widget>[
           Expanded(
             child: Container(
               decoration: const BoxDecoration(
                 borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                 color: Colors.pink,
               ),
               padding: const EdgeInsets.all(10),
               child: Text(
                 'Header ${e.boardName}',
                 style: Theme.of(context).primaryTextTheme.headline6,
               ),
             ),
           ),
         ],
       ),
       footer: Row(
         children: <Widget>[
           Expanded(
             child: Container(
               decoration: const BoxDecoration(
                 borderRadius:
                 BorderRadius.vertical(bottom: Radius.circular(7.0)),
                 color: Colors.pink,
               ),
               padding: const EdgeInsets.all(10),
               child: Text(
                 'Footer ${e.boardName}',
                 style: Theme.of(context).primaryTextTheme.headline6,
               ),
             ),
           ),
         ],
       ),
       leftSide: const VerticalDivider(
         color: Colors.pink,
         width: 1.5,
         thickness: 1.5,
       ),
       rightSide: const VerticalDivider(
         color: Colors.pink,
         width: 1.5,
         thickness: 1.5,
       ),
       children: _buildItem(e.taskList),
     );
   }).toList();
  }

}

List<DragAndDropItem> _buildItem(List<TaskModel> taskList) {

  return taskList.map((e) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(e.taskName),
      ),
    );
  }).toList();

}




