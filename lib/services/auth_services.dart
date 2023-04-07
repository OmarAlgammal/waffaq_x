import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class AuthBase {
  Future<UserCredential> signInWithFacebook();

  Stream<User?> loginStatus();

  User? currentUser();

  Future<void> signOut();
}

class AuthServices extends AuthBase {
  @override
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    UserCredential credential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    return credential;
  }

  @override
  Stream<User?> loginStatus() => FirebaseAuth.instance.authStateChanges();

  @override
  User? currentUser() => FirebaseAuth.instance.currentUser;

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
