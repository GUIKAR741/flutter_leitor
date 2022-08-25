import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../interfaces/auth.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> getLogin() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } catch (error) {
      debugPrint(error.toString());
    }
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  @override
  User? getUser() {
    return _auth.currentUser;
  }

  @override
  Future getLogout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
