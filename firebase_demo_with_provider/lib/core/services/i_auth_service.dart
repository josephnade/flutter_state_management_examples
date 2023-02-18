import 'package:firebase_demo_with_provider/core/models/user.dart';

abstract class IAuthService {
  Future<MyUser> createUserWithEmailAndPassword({required String email, required String password});
  Future<MyUser> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Stream<MyUser> get onAuthStateChanged;
}
