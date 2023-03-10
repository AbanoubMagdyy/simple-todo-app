import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/bloc/cubit.dart';
import '../shared/bloc/states.dart';

class TodoScreen extends StatelessWidget {
   const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>TodoCubit()..createDB(),
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){},

        builder: (context,state){
          var cubit = TodoCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                'TODO App',
                style: TextStyle(color: Colors.black),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
               onTap: (index){
                 cubit.changeBNB(index);
               },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task,
                    color: Colors.black,
                  ),
                  label: 'tasks',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.cloud_done,
                      color: Colors.black,
                    ),
                    label: 'done',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                      color: Colors.black,
                    ),
                    label: 'archived'),
              ],
            ),
            body:cubit.screens[cubit.currentIndex]
          );
        },
      ),
    );
  }
}
