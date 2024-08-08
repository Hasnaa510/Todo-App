import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled8/Counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit(super.initialState);

  static CounterCubit get(context) => BlocProvider.of(context);

int counter = 1;
void plus(){
  counter++;
  emit(CounterPlusState(counter));
}
  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }





}