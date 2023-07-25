import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo/shared/bloc/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../screens/archived.dart';
import '../../screens/done.dart';
import '../../screens/task.dart';


class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialState());

  bool showButton = false;
  Database? dataBase;
  List<Map> newTasks = [];
  List<Map> newDone = [];
  List<Map> newArchived = [];
  IconData doneIcon =    Icons.cloud_done_outlined;


  List<Widget> screens = [
    const TaskScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];

  int currentIndex = 0;

  void changeBNB(index) {
    currentIndex = index;
    emit(ChangBNBState());
  }

   showBS(bool showBS) {
    showButton = showBS;
    emit(ShowBSState());
  }


  static TodoCubit get(context) => BlocProvider.of(context);

  Future createDB() {
    return openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT, date TEXT, time TEXT, tasks TEXT,status TEXT)');
    }, onOpen: (database) {
      getDateFromDB(database);

    }).then((value) {
      dataBase = value;
      emit(CreateDBState());
    });
  }

   insertDB({
    required String title,
    required String time,
    required String date,
    required String tasks,
  }) async {
   await dataBase?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,tasks,status) VALUES ("$title","$time","$date","$tasks","new") ')
          .then((value) {
        emit(InsertDBState());
        getDateFromDB(dataBase);
      });
      return Future(() => null);
    });
  }

  void getDateFromDB(database) {
    newTasks =[];
    newDone = [];
    newArchived = [];

    database.rawQuery('SELECT * FROM tasks').then((value){


    value.forEach((element){
      if(element['status'] == 'new'){
        newTasks.add(element);
      }
      else  if(element['status'] == 'done'){
        newDone.add(element);
      } else {
        newArchived.add(element);
      }
    });

      emit(GetDBState());
    });
  }

  void updateDB(
  {
  required String status,
  required int id
}
      ){
    dataBase?.rawUpdate(
      'UPDATE tasks SET status =? WHERE id =? ' , [status , id]
    ).then((value) {
      getDateFromDB(dataBase);
      emit(UpdateDBState());
    });
  }

  void deleteDB(
  {
  required int id
}
      ){
    dataBase?.rawDelete('DELETE FROM tasks WHERE id =?' ,[id]).then((value) {
      getDateFromDB(dataBase);
      emit(DeleteDBState());
    });
  }
}
