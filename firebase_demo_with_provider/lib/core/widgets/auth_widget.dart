// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_demo_with_provider/core/widgets/error_page.dart';
import 'package:firebase_demo_with_provider/views/home_page.dart';
import 'package:firebase_demo_with_provider/views/sign_in_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_demo_with_provider/core/models/user.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key, required this.snapshot}) : super(key: key);
  final AsyncSnapshot<MyUser?> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      return snapshot.hasData ? const HomePage() : const SignInPage();
    }
    return const ErrorPage();
  }
}
