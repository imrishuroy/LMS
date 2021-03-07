import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms/screens/add_profile_screen.dart';
import 'package:lms/screens/edit_profile_screen.dart';
import 'package:lms/services/database_service.dart';

class UserProfile extends StatelessWidget {
  final DataBase? database;

  UserProfile({Key? key, this.database}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database?.profileDataSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data?.size == 0) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProfileScreen(database: database),
                  ),
                );
              },
              child: Text('Add Your Profile'),
            ),
          );
        }
        // QuerySnapshot? querySnapshot = snapshot.data;
        return ListView.builder(
          itemCount: snapshot.data?.size,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Text(
                    '${snapshot.data?.docs[index]['name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    'Father\'s name',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Text(
                    '${snapshot.data?.docs[index]['father_name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    'Mother\'s Name',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Text(
                    '${snapshot.data?.docs[index]['mother_name']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ),
                  child: Text(
                    '${snapshot.data?.docs[index]['mobile_no']}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          database: database,
                        ),
                      ),
                    ),
                    child: Text('Edit Profile'),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
