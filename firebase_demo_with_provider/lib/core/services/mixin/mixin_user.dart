import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

mixin ConvertUser {
  MyUser convertUserCredential(UserCredential user) {
    return MyUser(id: user.user!.uid, email: user.user!.email!);
  }

  MyUser convertUser(User? user) {
    return MyUser(id: user!.uid, email: user.email!);
  }
}
