import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lms/services/auth_service.dart';
import 'package:lms/services/database_service.dart';
import 'package:lms/services/database_service.dart';
import 'package:lms/widgets/display_image.dart';
import 'package:lms/widgets/user_profile.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // String documentId() => DateTime.now().toIso8601String();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    // final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => auth.signOut(),
          ),
          SizedBox(width: 10.0),
        ],
        centerTitle: true,
        title: Text('Your Profile'),
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              DisplayImage(database: database),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
      body: UserProfile(
        database: database,
      ),
    );
  }
}
