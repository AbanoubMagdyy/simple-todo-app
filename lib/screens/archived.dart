import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/bloc/cubit.dart';
import '../../shared/bloc/states.dart';
import '../components/components.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return  cubit.newArchived.isEmpty ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.menu_sharp,size: 50,),
              Text('NO TASKS HERE'),
            ],
          ),
        ) :
        Column(
          children: [
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => todoItem(cubit.newArchived[index],context),
                  separatorBuilder: (context, index) => const SizedBox(height: 0),
                  itemCount: cubit.newArchived.length),
            )
          ],
        );
      },

    );
  }
}
