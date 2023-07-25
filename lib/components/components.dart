import 'package:flutter/material.dart';
import '../shared/bloc/cubit.dart';

Widget screens(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        TodoCubit.get(context).deleteDB(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 162,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffe2eede),
              boxShadow: const [
                 BoxShadow(
                  color: Color(0xffabcea1),
                  spreadRadius: 3
                )
              ],
              borderRadius: BorderRadius.circular(10),),
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
                    fontSize: 15,
                  ),
                ),

                /// date and time
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        '${model['date']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.teal
                        ),
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

                Expanded(
                  child: Text(
                    '${model['tasks']}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                /// ICONS

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          TodoCubit.get(context)
                              .updateDB(status: 'done', id: model['id']);
                        },
                        icon: model['status'] == 'done'
                            ? const Icon(Icons.cloud_done)
                            : const Icon(Icons.cloud_done_outlined)),
                    IconButton(
                        onPressed: () {
                          TodoCubit.get(context)
                              .updateDB(status: 'archived', id: model['id']);
                        },
                        icon: const Icon(Icons.archive)),
                    IconButton(
                        onPressed: () {
                          TodoCubit.get(context).deleteDB(id: model['id']);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController controller,
  required String labelText,
  required String validatorText,
  Function()? onTap,
  required IconData prefixIcon,
  bool hideKeyboard = false,
}) =>
    TextFormField(
      onTap: onTap,
      readOnly: hideKeyboard,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),),
    );
