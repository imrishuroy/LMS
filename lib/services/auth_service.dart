import 'package:firebase_auth/firebase_auth.dart';
import 'package:lms/models/app_user.dart';

abstract class AuthServices {
  Stream<AppUser?> get onAuthChanges;
  Future<AppUser?> currentUser();
  Future<AppUser?> createUserWithEmailAndPassword({
    String? email,
    String? password,
  });
  Future<AppUser?> signInWithEmailAndPassword({
    String? email,
    String? password,
  });
  Future<void> signOutUser();
}

class Auth implements AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _appUser(User? user) {
    if (user == null) {
      return null;
    } else {
      return AppUser(
        uid: user.uid,
        name: user.displayName,
        photUrl: user.photoURL,
        // isVerified: user.emailVerified,
      );
    }
  }

  @override
  Stream<AppUser?> get onAuthChanges {
    return _auth.authStateChanges().map(_appUser);
  }

  @override
  Future<AppUser?> currentUser() async {
    final user = _auth.currentUser;
    return _appUser(user);
  }

  @override
  Future<AppUser?> createUserWithEmailAndPassword(
      {String? email, String? password}) async {
    final UserCredential authResult = await _auth
        .createUserWithEmailAndPassword(email: email!, password: password!);
    // User user = _auth.currentUser;
    // if (!user.emailVerified) {
    //   await user.sendEmailVerification();
    //   user.reload();
    // } else {
    //   user.reload();
    //   return _appUser(authResult.user);
    // }
    // user.reload();
    // return _appUser(authResult.user);
    await _auth.currentUser!.sendEmailVerification();
    return _appUser(authResult.user);
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    return _appUser(authResult.user);
  }

  sendEmailVerificationLink() async {
    User user = _auth.currentUser!;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<void> signOutUser() async {
    await _auth.signOut();
  }
}
