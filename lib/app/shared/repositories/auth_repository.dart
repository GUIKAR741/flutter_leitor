import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../interfaces/auth.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getLogin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential))?.user;
    return user;
  }

  @override
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  @override
  Future getLogout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
