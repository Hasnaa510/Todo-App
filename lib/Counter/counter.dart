import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(CounterInitialState()),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterPlusState) print('Plus State ${state.counter}');
          if (state is CounterMinusState) print('Minus State ${state.counter}');

        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).plus();
                  },
                  child: const Text('Plus',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text('${CounterCubit.get(context).counter}',
                      style:
                          const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).minus();

                  },
                  child: const Text('Minus',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
