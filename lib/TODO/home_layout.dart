import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/TODO/cubit_todo/cubit.dart';
import 'package:untitled8/TODO/cubit_todo/states_todo.dart';



class HomeLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit(AppInitialState())..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              child:  Icon(cubit.fabIcon),
              onPressed: ()  async
              {
                if(cubit.isBottomSheetShown)
                {
                  if(cubit.formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                      title:cubit. titleController.text,
                      time:cubit. timeController.text,
                      date:cubit. dateController.text,
                    ).then((value){


                        Navigator.pop(context);
                        cubit.showBottomSheet(
                         isShow: false,
                          icon: Icons.edit,
                        );

                    });
                  }
                }else
                {
                  cubit.scaffoldKey.currentState?.showBottomSheet((context){
                    return Container(
                      color: Colors.grey[300],
                      padding:const EdgeInsets.all(20),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller:cubit.titleController ,
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'title must not be empty';
                                }
                              },
                              decoration:const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Task title'),
                                prefixIcon: Icon(Icons.title),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller:cubit. timeController,
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'time must not be empty';
                                }
                              },
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {

                                  print(value!.format(context));
                                  cubit.timeController.text=value.format(context);

                                });
                              },
                              decoration:const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Task time'),
                                prefixIcon: Icon(Icons.watch_later_outlined),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller:cubit. dateController,
                              validator: (value) {
                                if (value!.isEmpty){
                                  return 'date must not be empty';
                                }
                              },
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2025-03-14'),
                                ).then((value) {
                                  print(DateFormat.yMMMd().format(value!));
                                  cubit.dateController.text =DateFormat.yMMMd().format(value) ;
                                });
                              },
                              decoration:const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Task date'),
                                prefixIcon: Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).closed.then((value){
                cubit.showBottomSheet(isShow: false, icon: Icons.edit);

                });
                cubit.showBottomSheet(isShow: true, icon: Icons.add);

                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:cubit. currentIndex,
              onTap: (index) {
                cubit.bottomNavBar(index);
              },
              items:
              const[
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',

                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',

                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex] ,
          );
        } ,
      ),
    );
  }






}
