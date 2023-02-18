import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_with_provider/core/models/user.dart';
import 'package:firebase_demo_with_provider/core/services/i_auth_service.dart';
import 'package:firebase_demo_with_provider/core/services/mixin/mixin_user.dart';

class AuthService with ConvertUser implements IAuthService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  @override
  Future<MyUser> createUserWithEmailAndPassword({required String email, required String password}) async {
    UserCredential tempUser = await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
    return convertUserCredential(tempUser);
  }

  @override
  Future<MyUser> signInWithEmailAndPassword({required String email, required String password}) async {
    UserCredential tempUser = await _authInstance.signInWithEmailAndPassword(email: email, password: password);
    return convertUserCredential(tempUser);
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  @override
  Stream<MyUser> get onAuthStateChanged => _authInstance.authStateChanges().map(convertUser);
}
