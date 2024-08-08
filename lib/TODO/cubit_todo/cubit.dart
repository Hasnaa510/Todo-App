import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled8/TODO/cubit_todo/states_todo.dart';

import '../archivedTasks_screen.dart';
import '../doneTasks_screen.dart';
import '../tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(super.initialState);

static AppCubit get(context) => BlocProvider.of(context);



  int currentIndex=0;
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];


  List<Widget> screens= const[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles=
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];



  late Database database ;
  bool isBottomSheetShown =false;
  IconData fabIcon =Icons.edit;
  var scaffoldKey =GlobalKey<ScaffoldState>();
  var timeController =TextEditingController();
  var titleController =TextEditingController();
  var dateController =TextEditingController();
  var formKey = GlobalKey<FormState>();

  void bottomNavBar(int index){
    currentIndex= index;
    emit(AppBottomNavBarState());
  }

  void showBottomSheet({
    required bool isShow,
    required IconData icon ,}){

    isBottomSheetShown=isShow;
    fabIcon =icon;

    emit(AppShowBottomSheetState());

  }


  void createDatabase()async
  {
    database = await openDatabase(
      'path',
      version: 1,
      onCreate: (database, version) {
        emit(AppCreateDatabaseState());
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,  time TEXT,  date TEXT,  status TEXT)').then((value) {
          print('table created');
          emit(AppCreateDatabaseState());
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
        emit(AppCreateDatabaseState());

      },
    ).then((value) {
      emit(AppCreateDatabaseState());

      return database = value;
    }
      );

  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,

  }) async
  {
    return await database.rawInsert('INSERT INTO tasks (title , time , date , status) values ("$title", "$time" ,"$date", "new")').then((value)
    {
      emit(AppInsertToDatabaseState());

      print('$value inserted successfully');

      getDataFromDatabase(database);
    });
  }

  void getDataFromDatabase(database)
  {

    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseState());

    database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((element)
      {
        if(element['status']== 'new')
        {
          newTasks.add(element);
        }
        else if(element['status']== 'done') {
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());




    }) ;

  }

  void updateDatabase({
    required String status,
    required int id,
  })
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id,]
    ).then((value)
    {
      emit(AppUpdateDatabaseState());

      getDataFromDatabase(database);

    });
  }

  void deleteDatabase({
  required int id,
 }
      ){
      database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]
     ).then((value){
       emit(AppDeleteDatabaseState());

       getDataFromDatabase(database);
     });
  }

}