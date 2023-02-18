import 'package:firebase_demo_with_provider/core/services/i_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuthService>(context, listen: false);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late String email, password;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Page'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            TextFormField(
              validator: (value) => value.toString().contains('@') ? null : "Invalid Email",
              onChanged: (value) {
                email = value;
              },
            ),
            TextFormField(
              validator: (value) => value.toString().length > 6 ? null : "Invalid Email",
              onChanged: (value) {
                password = value;
              },
            ),
            MaterialButton(
              child: const Text("Sign In"),
              onPressed: () async {
                await authService.signInWithEmailAndPassword(email: email, password: password);
              },
            ),
            MaterialButton(
              child: const Text("Create User"),
              onPressed: () async {
                await authService.createUserWithEmailAndPassword(email: email, password: password);
              },
            )
          ]),
        ),
      ),
    );
  }
}
