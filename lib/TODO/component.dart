import 'package:flutter/material.dart';
import 'package:untitled8/TODO/cubit_todo/cubit.dart';

Widget buildTaskItem(Map model, context)=>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed:(direction) {
    AppCubit.get(context).deleteDatabase(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text('${model['date']}'),

        ),

        const SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children:  [

               Text('${model['title']}',

                style: const TextStyle(

                    fontWeight: FontWeight.bold,

                    fontSize: 20.0

                ),

              ),

              Text('${model['time']}',

                style: TextStyle(

                    color: Colors.grey,

                    fontSize: 20.0

                ),

              ),



            ],

          ),

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateDatabase(status: 'done', id: model['id']);

            },

            icon: const Icon(Icons.check_box_rounded,

            color: Colors.green),

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateDatabase(status: 'archived', id: model['id']);

          },

          icon: const Icon(Icons.archive,

              color: Colors.black45),

        ),

      ],

    ),

  ),
);