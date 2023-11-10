import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../shared/bloc/cubit.dart';
import '../shared/bloc/states.dart';
import '../style/color.dart';

class TodoScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final taskController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final double requiredHeight = 350;


  TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TodoCubit.get(context);
          final pageController =
              PageController(initialPage: cubit.currentIndex);
          String titleAppBar = nameAppBar(cubit.currentIndex);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text(
                  'TODO App',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBNB(index);
                  pageController.animateToPage(cubit.currentIndex,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.ease);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task,
                      color: Colors.black,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.cloud_done,
                      color: Colors.black,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                      color: Colors.black,
                    ),
                    label: 'Archived',
                  ),
                ],
              ),
              body: LayoutBuilder(
                 builder: (BuildContext context, BoxConstraints constraints) {
                   final double availableHeight = constraints.maxHeight;
                 return Column(
                   children: [
                     /// field add the task
                     if(requiredHeight <= availableHeight)
                     Container(
                       height: 60,
                       width: double.infinity,
                       margin: const EdgeInsets.all(10.0),
                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       decoration: BoxDecoration(
                         color: defColor,
                         borderRadius: BorderRadius.circular(15),
                       ),
                       child: Row(
                         children: [
                           /// TITLE
                           Expanded(
                             child: Text(
                               titleAppBar,
                               style: const TextStyle(fontSize: 15),
                             ),
                           ),

                           /// ICON
                           Container(
                             decoration: BoxDecoration(
                               color: secondColor,
                               borderRadius: BorderRadius.circular(15),
                             ),
                             child: IconButton(
                               onPressed: () {
                                 /// BOTTOM SHEET
                                 showModalBottomSheet(
                                   context: context,
                                   isScrollControlled: true,
                                   shape: const RoundedRectangleBorder(
                                     borderRadius: BorderRadius.vertical(
                                       top: Radius.circular(50),
                                     ),
                                   ),
                                   backgroundColor: defColor,
                                   builder: (context) => bottomSheetContent(context: context, index: cubit.currentIndex, cubit: cubit),
                                 );
                               },
                               icon: const Icon(
                                 Icons.add,
                                 size: 30,
                               ),
                             ),
                           )
                         ],
                       ),
                     ),

                     /// SCREEN TITLE
                     if(requiredHeight <= availableHeight)
                       Padding(
                         padding: const EdgeInsets.only(bottom: 10.0),
                         child: Text(
                         screenTitle(cubit.currentIndex),
                         style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                         ),
                     ),
                       ),

                     /// BODY
                     Expanded(
                       child: PageView(
                         physics: const BouncingScrollPhysics(),
                         controller: pageController,
                         children: cubit.screens,
                         onPageChanged: (int index) {
                           cubit.changeBNB(index);
                         },
                       ),
                     ),
                   ],
                 );
                 }
              ),
          );
        },
    );
  }

  Widget addNewTask(context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              /// TOP BAR
              Container(
                height: 10,
                width: 110,
                margin: const EdgeInsetsDirectional.only(bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: secondColor),
              ),

              /// TEXT FORM FIELDS
              Form(
                key: formKey,
                child: Column(
                  children: [
                    /// title
                    defaultTextField(
                      controller: titleController,
                      labelText: 'Title',
                      prefixIcon: Icons.title,
                    ),

                    /// task
                    defaultTextField(
                      maxLines: 4,
                      controller: taskController,
                      labelText: 'Task',
                      prefixIcon: Icons.task_alt,
                    ),

                    /// date
                    defaultTextField(
                        hideKeyboard: true,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2199-11-31'))
                              .then((value) {
                            if (value != null) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value);
                            }
                          });
                        },
                        controller: dateController,
                        labelText: 'Date',
                        prefixIcon: Icons.date_range),

                    /// TIME AND ADD BUTTON
                    Row(
                      children: [
                        /// time
                        Expanded(
                          child: defaultTextField(
                            hideKeyboard: true,
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  timeController.text = value.format(context);
                                }
                              });
                            },
                            controller: timeController,
                            labelText: 'Time',
                            prefixIcon: Icons.timelapse_rounded,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 120,
                          height: 70,
                          decoration: BoxDecoration(
                            color: secondColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                TodoCubit.get(context).insertDB(
                                  title: titleController.text,
                                  time: timeController.text,
                                  date: dateController.text,
                                  tasks: taskController.text,
                                );
                                Navigator.pop(context);
                                titleController.clear();
                                taskController.clear();
                                timeController.clear();
                                dateController.clear();
                              }
                            },
                            icon: const Icon(
                              Icons.check,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
  Widget bottomSheetContent({
    required context,
    required index,
    required cubit,
  }){
    Widget widget = Container() ;
    switch (index) {
      case 0 :
        widget = addNewTask(context);
        break;
      case 1 :
        widget = addToDoneTask(context,cubit);
        break;
      case 2 :
        widget = addToArchivedTask(context,cubit);
        break;
    }
    return widget;
  }
  }