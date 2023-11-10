import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/bloc/cubit.dart';
import '../../shared/bloc/states.dart';
import '../components/components.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Column(
          children: [
            ///TASKS
            if(cubit.newTask.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.menu_sharp,
                        size: 50,
                      ),
                      Text('NO TASKS HERE'),
                    ],
                  ),
                ),
              ),

            if(cubit.newTask.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      todoItem(cubit.newTask[index], context),
                  itemCount: cubit.newTask.length,
                ),
              )
          ],
        );
      },
    );
  }
}
