import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class DataBase {
  Future<void> setData({
    String? name,
    String? fatherName,
    String? motherName,
    String? mobileNo,
    File? image,
    String? documentId,
  });

  String? get id;
  Stream<QuerySnapshot> get profileDataSnapshot;
}

class FireStoreDataBase implements DataBase {
  final String? uid;

  FireStoreDataBase({this.uid});

  @override
  String? get id => uid;

  @override
  Future<void> setData({
    String? name,
    String? fatherName,
    String? motherName,
    String? mobileNo,
    File? image,
    String? documentId,
    // adding new documents
  }) async {
    final firebaseStorage = FirebaseStorage.instance;
    final reference =
        //   FirebaseFirestore.instance.doc('users/$uid/userData/$documentId/');
        // FirebaseFirestore.instance.doc('users/$uid/userData/$uid/');

        // adding new path
        FirebaseFirestore.instance.doc('users/$uid');
    // new data
    //  FirebaseFirestore.instance.doc('users/$uid/');
    final ref = firebaseStorage.ref().child('user_image').child('$uid.jpg');
    await ref.putFile(image!);
    final imageUrl = await ref.getDownloadURL();

    await reference.set(
      {
        'name': name,
        'image_url': imageUrl,
        'father_name': fatherName,
        'mother_name': motherName,
        'mobile_no': mobileNo,
        'id': uid,
      },
    );
  }

  @override
  Stream<QuerySnapshot> get profileDataSnapshot {
    return FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
