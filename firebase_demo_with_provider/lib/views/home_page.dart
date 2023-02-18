import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/i_auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          MaterialButton(
            child: const Text("Sign Out"),
            onPressed: () {
              authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
