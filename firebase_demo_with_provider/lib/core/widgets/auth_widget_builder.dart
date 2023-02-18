// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_demo_with_provider/core/services/i_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({
    Key? key,
    required this.onPageBuilder,
  }) : super(key: key);
  final Widget Function(BuildContext context, AsyncSnapshot<MyUser?> snapshot) onPageBuilder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuthService>(context, listen: false);
    return StreamBuilder<MyUser>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final userData = snapshot.data;
        if (userData != null) {
          return MultiProvider(
            providers: [Provider.value(value: userData)],
            child: onPageBuilder(context, snapshot),
          );
        }
        return onPageBuilder(context, snapshot);
      },
    );
  }
}
