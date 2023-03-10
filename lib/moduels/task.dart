import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../shared/bloc/cubit.dart';
import '../../shared/bloc/states.dart';
import '../components/components.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  static var titleController = TextEditingController();
  static var dateController = TextEditingController();
  static var timeController = TextEditingController();
  static var taskController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Column(
          children: [
            ///field add the task
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: HexColor('#e2eede'),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                        child: Text(
                      'Add New Task',
                      style: TextStyle(fontSize: 15),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Container(
                          color: HexColor('#abcea1'),
                          child: IconButton(
                              onPressed: () {
                                if (cubit.showButton == true) {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(context);
                                    cubit.showBS(false);
                                    cubit.insertDB(
                                        title: titleController.text,
                                        time: timeController.text,
                                        date: dateController.text,
                                        tasks: taskController.text);
                                  }
                                } else {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            color: Colors.white,
                                            width: double.infinity,
                                            child: Form(
                                              key: formKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  color: HexColor('#e2eede'),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        usetextFormField(
                                                            onTap: () {},
                                                            validatorText:
                                                                'title is empty',
                                                            controller:
                                                                titleController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            labelText: 'title',
                                                            prefixIcon:
                                                                Icons.title),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        usetextFormField(
                                                            onTap: () {
                                                              showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime
                                                                              .now(),
                                                                      lastDate:
                                                                          DateTime.parse(
                                                                              '2199-11-31'))
                                                                  .then(
                                                                      (value) {
                                                                dateController
                                                                    .text = DateFormat
                                                                        .yMMMd()
                                                                    .format(
                                                                        value!);
                                                              });
                                                            },
                                                            validatorText:
                                                                'date is empty',
                                                            controller:
                                                                dateController,
                                                            labelText: 'date',
                                                            prefixIcon: Icons
                                                                .date_range),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        usetextFormField(
                                                            onTap: () {
                                                              showTimePicker(
                                                                      context:
                                                                          context,
                                                                      initialTime:
                                                                          TimeOfDay
                                                                              .now())
                                                                  .then(
                                                                      (value) {
                                                                timeController
                                                                    .text = value
                                                                        ?.format(
                                                                            context)
                                                                    as String;
                                                              });
                                                            },
                                                            validatorText:
                                                                'time is empty',
                                                            controller:
                                                                timeController,
                                                            labelText: 'Time',
                                                            prefixIcon: Icons
                                                                .timelapse_rounded),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        usetextFormField(
                                                            onTap: () {},
                                                            validatorText:
                                                                'tasks is empty',
                                                            controller:
                                                                taskController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            labelText: 'Tasks',
                                                            prefixIcon:
                                                                Icons.task_alt),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).closed.then((value) {
                                    cubit.showBS(false);
                                  });
                                  cubit.showBS(true);
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              )),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            ///NAME SCREEN
            const Text(
              'Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ///TASKS
            cubit.newTasks.isEmpty
                ? Expanded(
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
                )
                : Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          screens(cubit.newTasks[index], context),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 9,
                      ),
                      itemCount: cubit.newTasks.length,
                    ),
                  )
          ],
        );
      },
    );
  }
}
