import 'package:flutter/material.dart';

import '../style/color.dart';
import 'components.dart';



Widget addToDoneTask(context,cubit)=> Container(
  height:
  MediaQuery.of(context).size.height / 2,
  padding:
  const EdgeInsetsDirectional.all(20),
  child: Column(
    children: [
      /// TOP BAR
      Container(
        height: 10,
        width: 110,
        margin:
        const EdgeInsetsDirectional.only(
            bottom: 15),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(15),
            color: secondColor),
      ),

      /// ITEMS
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if(cubit.allTasks[index]['status'] != 'done') {
              return addToDoneOrArchivedTaskItem(
                model:
                cubit.allTasks[index],
                context: context,
                isTheTaskIsDone: true,
              );
            } else{
              return Container();
            }
          },
          itemCount: cubit.allTasks.length,
        ),
      ),
    ],
  ),
);

Widget addToArchivedTask(context,cubit)=> Container(
  height:
  MediaQuery.of(context).size.height / 2,
  padding:
  const EdgeInsetsDirectional.all(20),
  child: Column(
    children: [
      /// TOP BAR
      Container(
        height: 10,
        width: 110,
        margin:
        const EdgeInsetsDirectional.only(
            bottom: 15),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(15),
            color: secondColor),
      ),

      /// ITEMS
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            if(cubit.allTasks[index]['status'] != 'archived') {
              return addToDoneOrArchivedTaskItem(
                model:
                cubit.allTasks[index],
                context: context,
                isTheTaskIsDone: false,
              );
            } else{
              return Container();
            }
          },
          itemCount: cubit.allTasks.length,
        ),
      ),
    ],
  ),
);

String nameAppBar(int index) {
  String nameAppBar = '';
  switch (index) {
    case 0:
      nameAppBar = 'Add new task';
      break;
    case 1:
      nameAppBar = 'Add new task to done task';
      break;
    case 2:
      nameAppBar = 'Add new task to archived task';
      break;
  }
  return nameAppBar;
}

String screenTitle(int index) {
  String nameAppBar = '';
  switch (index) {
    case 0:
      nameAppBar = 'Tasks';
      break;
    case 1:
      nameAppBar = 'Done';
      break;
    case 2:
      nameAppBar = 'Archived';
      break;
  }
  return nameAppBar;
}


