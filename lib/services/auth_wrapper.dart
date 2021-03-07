import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms/models/app_user.dart';
import 'package:lms/screens/home_screen.dart';
import 'package:lms/screens/register_screen.dart';

import 'package:lms/services/auth_service.dart';
import 'package:lms/services/database_service.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper extends StatelessWidget {
  final firebaseAuth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance.collection('users');

  // updateUserProfile({String uid, BuildContext context}) async {
  //   DocumentSnapshot doc = await usersRef.doc(uid).get();
  //   if (!doc.exists) {
  //     await Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => AddProfileScreen()));
  //   }
  // }

  Future<bool> checkAvailabledata(String uid) async {
    DocumentSnapshot doc = await usersRef.doc(uid).get();
    if (!doc.exists) {
      return true;
    } else {
      return false;
    }
    // return false;
    // bool availableData = !doc.exists;
    // return availableData;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context);
    return StreamBuilder<AppUser?>(
      stream: auth.onAuthChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          AppUser? user = snapshot.data;
          if (user == null) {
            return RegisterScreen();
          } else {
            // return SucussScreen();

            return Provider<DataBase>(
              create: (context) => FireStoreDataBase(uid: user.uid),
              child: HomeScreen(
                uid: user.uid,
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
