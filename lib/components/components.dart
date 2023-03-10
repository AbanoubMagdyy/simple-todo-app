import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
              color: HexColor('#e2eede'),
              boxShadow: [
                BoxShadow(
                  color: HexColor('#abcea1'),
                  spreadRadius: 3
                )
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',

                  //  'title' ,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Text(
                      '${model['date']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${model['time']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: Text(
                    '${model['tasks']}',
                    maxLines: 2,
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

Widget usetextFormField({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  required String labelText,
  required String validatorText,
  bool isPassword = false,
  Function()? onTap,
  Function()? iconPressed,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  double borderRadius = 30,
  required IconData prefixIcon,
  IconData? endIcon,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword,
      onChanged: onChanged,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          labelText: labelText,
          suffixIcon: IconButton(onPressed: iconPressed, icon: Icon(endIcon)),
          prefixIcon: Icon(prefixIcon)),
    );
