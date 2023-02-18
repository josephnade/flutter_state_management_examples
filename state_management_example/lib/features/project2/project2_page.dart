import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_example/features/project2/names_cubit.dart';

const Iterable<String> _userList = ['Jamal', 'Alene', 'Aurelie', 'Johanna', 'Theodora'];

class Project2 extends StatelessWidget {
  const Project2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NamesCubit>(create: (_) => NamesCubit(userList: _userList), child: const Project2App());
  }
}

void main() => runApp(const Project2App());

class Project2App extends StatelessWidget {
  const Project2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: BlocBuilder<NamesCubit, String?>(builder: (context, String? state) {
          if (state != null) {
            return Center(
              child: Column(children: [Text(state, style: Theme.of(context).textTheme.headline3), const RandomNameButton()]),
            );
          } else {
            return const Center(child: RandomNameButton());
          }
        }),
      ),
    );
  }
}

class RandomNameButton extends StatelessWidget {
  const RandomNameButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<NamesCubit>().getRandomName();
        },
        child: Text("Fetch Random User"));
  }
}
