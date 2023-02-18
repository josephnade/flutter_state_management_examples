// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state_management_example/features/project1/counter_cubit.dart';

class CubitExampleHomePage extends StatelessWidget {
  const CubitExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(create: (context) => CounterCubit(), child: const CubitExampleView());
  }
}

class CubitExampleView extends StatelessWidget {
  const CubitExampleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BB App Bar'),
      ),
      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        TextButton(onPressed: () => context.read<CounterCubit>().increment(), child: const Text("Increment")),
        TextButton(onPressed: () => context.read<CounterCubit>().decrement(), child: const Text("Decrement"))
      ]),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Component(number: state.toString());
        },
      ),
    );
  }
}

class Component extends StatelessWidget {
  final String number;
  const Component({
    Key? key,
    required this.number,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (context) {
        return Text(number, style: Theme.of(context).textTheme.headline3);
      }),
    );
  }
}
