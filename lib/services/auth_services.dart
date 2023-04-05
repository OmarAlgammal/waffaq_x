

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:waffaq_x/models/admin/admin_model.dart';
import 'package:waffaq_x/services/firestore_services.dart';
import 'package:waffaq_x/utilities/constants/texts/api.dart';

abstract class AuthBase{

  Future<UserCredential> signInWithFacebook();

  Stream<User?> loginStatus();

  User? currentUser();

  Future<void> signOut();
}

class AuthServices extends AuthBase{

  @override
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    UserCredential credential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    UserModel user = UserModel(uid: credential.user!.uid, email: credential.user?.email, name: credential.user?.displayName);
    await saveUserData(user: user);
    return credential;
  }

  saveUserData({required UserModel user,}) async{
    try{
      await FirestoreServices.instance.doc(path: '$usersPath${user.uid}', builder: (map) => UserModel.fromJson(map));
    }catch(e){
      await FirestoreServices.instance.setData(path: '$usersPath${user.uid}',data: user.toJson());
    }
  }

  @override
  Stream<User?> loginStatus() => FirebaseAuth.instance.authStateChanges();


  @override
  User? currentUser() => FirebaseAuth.instance.currentUser;

  @override
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }


}