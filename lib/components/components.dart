import 'package:flutter/material.dart';
import '../shared/bloc/cubit.dart';
import '../style/color.dart';

Widget todoItem(Map model, context) =>
    LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final double availableWidth = constraints.maxWidth;

      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: defColor,
            boxShadow: [BoxShadow(color: secondColor, spreadRadius: 3)],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title

                Text(
                  '${model['title']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                /// date and time
                if (290 < availableWidth)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          '${model['date']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.teal),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${model['time']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                Text(
                  '${model['tasks']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                /// ICONS

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// DONE

                    IconButton(
                        onPressed: () {
                          if (model['status'] == 'done') {
                            TodoCubit.get(context)
                                .updateDB(status: 'new', id: model['id']);
                          } else {
                            TodoCubit.get(context)
                                .updateDB(status: 'done', id: model['id']);
                          }
                        },
                        icon: model['status'] == 'done'
                            ? Icon(
                                Icons.cloud_done,
                                color: secondColor,
                              )
                            : const Icon(Icons.cloud_done_outlined)),

                    /// ARCHIVED

                    IconButton(
                        onPressed: () {
                          if (model['status'] == 'archived') {
                            TodoCubit.get(context)
                                .updateDB(status: 'new', id: model['id']);
                          } else {
                            TodoCubit.get(context)
                                .updateDB(status: 'archived', id: model['id']);
                          }
                        },
                        icon: model['status'] == 'archived'
                            ? Icon(
                                Icons.archive,
                                color: secondColor,
                              )
                            : const Icon(Icons.archive_outlined)),

                    /// DELETE

                    IconButton(
                        onPressed: () {
                          TodoCubit.get(context).deleteDB(id: model['id']);
                        },
                        icon: const Icon(Icons.delete_outline)),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

Widget defaultTextField({
  required TextEditingController controller,
  required String labelText,
  Function()? onTap,
  required IconData prefixIcon,
  bool hideKeyboard = false,
  int maxLines = 1,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onTap: onTap,
        readOnly: hideKeyboard,
        maxLines: maxLines,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );

Widget addToDoneOrArchivedTaskItem(
        {required Map model,
        required context,
        required bool isTheTaskIsDone}) =>
    LayoutBuilder(
       builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;

       return   InkWell(
            onTap: () {
              if (isTheTaskIsDone) {
                TodoCubit.get(context).updateDB(status: 'done', id: model['id']);
              } else {
                TodoCubit.get(context).updateDB(status: 'archived', id: model['id']);
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: defColor,
                  boxShadow: [BoxShadow(color: secondColor, spreadRadius: 3)],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// title
                      Text(
                        '${model['title']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      /// date and time
                      if(290 < availableWidth)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Text(
                              '${model['date']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.teal),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${model['time']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// TASK
                      Text(
                        '${model['tasks']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
