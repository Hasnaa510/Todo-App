import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/TODO/cubit_todo/cubit.dart';
import 'package:untitled8/TODO/cubit_todo/states_todo.dart';
import 'component.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

    if (AppCubit.get(context).doneTasks.isNotEmpty) {
      return   ListView.separated(
          itemBuilder:(context, index) => buildTaskItem(AppCubit.get(context).doneTasks[index], context),
          separatorBuilder: (context, index) => Container(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
            ) ,
            color: Colors.grey[200],
            width: double.infinity,
            height: 2,
          ),
          itemCount: AppCubit.get(context).doneTasks.length);
    }
    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            Icon(
                Icons.menu,
                size: 130,
                color: Colors.grey),
            Text('No tasks yet, please add some tasks',
              style: TextStyle(color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
          ],
        ),
      );
    }

      },
    );
  }
}
