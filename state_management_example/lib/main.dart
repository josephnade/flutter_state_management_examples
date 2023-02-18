import 'package:flutter/material.dart';

import 'features/project1/cubit_example_screen.dart';
import 'features/project2/project2_page.dart';
import 'features/project3/bottom_app_bar_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ChangePageExample());
  }
}
