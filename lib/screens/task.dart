import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    color: const Color(0xffe2eede),
                    borderRadius: BorderRadius.circular(5),),
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
                          color: const Color(0xffabcea1),
                          child: IconButton(
                              onPressed: () {
                                if (cubit.showButton) {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(context);
                                    cubit.showBS(false);
                                    cubit.insertDB(
                                        title: titleController.text,
                                        time: timeController.text,
                                        date: dateController.text,
                                        tasks: taskController.text,);
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
                                                  color: const Color(0xffe2eede),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        /// title
                                                        defaultTextField(
                                                            onTap: () {},
                                                            validatorText:
                                                                'title is empty',
                                                            controller:
                                                                titleController,
                                                            labelText: 'title',
                                                            prefixIcon:
                                                                Icons.title,),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        /// date
                                                        defaultTextField(
                                                          hideKeyboard: true,
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
                                                                        if(value != null){
                                                                          dateController.text = DateFormat.yMMMd().format(value);
                                                                        }
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
                                                        /// time
                                                        defaultTextField(
                                                          hideKeyboard: true,
                                                            onTap: () {
                                                              showTimePicker(
                                                                      context:
                                                                          context,
                                                                      initialTime:
                                                                          TimeOfDay
                                                                              .now())
                                                                  .then(
                                                                      (value) {
                                                                        if(value != null) {
                                                                          timeController
                                                                    .text = value
                                                                        .format(
                                                                            context);
                                                                        }
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
                                                        /// task
                                                        defaultTextField(
                                                            onTap: () {},
                                                            validatorText:
                                                                'tasks is empty',
                                                            controller:
                                                                taskController,
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
                                    titleController.clear();
                                    taskController.clear();
                                    timeController.clear();
                                    dateController.clear();
                                  });
                                  cubit.showBS(true);
                                }
                              },
                              icon: cubit.showButton == false ? const Icon(
                                Icons.add,
                                size: 30,
                              ) : const Icon(
                                Icons.check,
                                size: 30,
                              ),
                          ),
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
