import 'package:bloc/bloc.dart';
import 'package:bloc_lazy_list_example/views/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void main() {
  Bloc.observer = PostBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class PostBlocObserver extends BlocObserver {
  void onCreate(BlocBase bloc) {
    'Bloc Created'.log();
    super.onCreate(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    'Bloc: $bloc'.log();
    super.onTransition(bloc, transition);
  }
}

extension Log on Object {
  void log() => devtools.log(toString());
}
