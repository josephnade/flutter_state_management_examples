// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_example/core/bloc/user_bloc.dart';

import '../core/extensions/app_ext.dart';
import '../core/widgets/fetch_users_button.dart';

void main() => runApp(const UsersPage());

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: const UserView(),
    );
  }
}

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: 100,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const FetchUserButton(url: UserUrl.users1, text: "List User#1"),
                    const FetchUserButton(url: UserUrl.users2, text: "List User#2")
                  ])),
              const SizedBox(height: 30),
              BlocBuilder<UserBloc, FetchResult?>(
                builder: (context, fetchResult) {
                  return fetchResult != null ? fetchResult.users.itemToWidget() : const Text("Boş");
                },
              )
            ],
          )),
    );
  }
}
