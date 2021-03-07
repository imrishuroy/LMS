import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms/services/auth_service.dart';
import 'package:lms/services/database_service.dart';
import 'package:lms/widgets/display_image.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServices>(context, listen: false);
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: database.profileDataSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.data?.size == 0) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 250.0,
                  color: Color.fromRGBO(0, 141, 82, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.image)),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Drawer(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  final name = snapshot.data?.docs[index]['name'];
                  final fatherName = snapshot.data?.docs[index]['father_name'];
                  final phoneNum = snapshot.data?.docs[index]['mobile_no'];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Color.fromRGBO(0, 141, 82, 1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 50.0),
                            DisplayImage(
                              database: database,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '$name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '$fatherName',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '$phoneNum',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {
                          // Update the state of the app.
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Item 3'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Item 4'),
                        onTap: () {},
                      ),
                      SizedBox(height: 150.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: RaisedButton(
                          color: Color.fromRGBO(255, 203, 0, 1),
                          onPressed: () => auth.signOutUser(),
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        }
        //   } else {
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   }
        // },
      },
    );
  }
}
