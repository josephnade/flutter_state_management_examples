import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../extensions/app_ext.dart';
import '../service/users_service.dart';

class FetchUserButton extends StatelessWidget {
  const FetchUserButton({
    Key? key,
    this.text = "",
    required this.url,
  }) : super(key: key);
  final String text;
  final UserUrl url;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<UserBloc>().add(LoadPersonAction(onLoader: UserService().fetchUser, url: url));
        },
        child: Text(text));
  }
}
