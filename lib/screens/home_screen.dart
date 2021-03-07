import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lms/screens/dashboard_screen.dart';
import 'package:lms/screens/gallery_screen.dart';
import 'package:lms/screens/happenings_screen.dart';
import 'package:lms/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';
  // final AppUser user;

  // const HomeScreen({Key key, this.user}) : super(key: key);
  //final AppUser user = AppUser(uid: null)
  final String? uid;

  HomeScreen({Key? key, this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final usersRef = FirebaseFirestore.instance.collection('users');
  // void setData() {
  //   final data = Provider.of<DataBase>(context, listen: false);
  //   data.setData(name: widget.user.name);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setData();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // updateUserProfile();
  // }

  // updateUserProfile() async {
  //   DocumentSnapshot doc = await usersRef.doc(widget.uid).get();
  //   if (!doc.exists) {
  //     await Navigator.pushNamed(context, AddProfileScreen.routeName);
  //   }
  // }

  int _currentIndex = 0;
  final tabs = [
    DashBoard(),
    // // Center(child: Text('Search')),
    HappeningScreen(),
    // // Center(child: Text('Camera')),
    GalleryScreen(),
    // AddProfileScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // final DataBase dataBase = Provider.of(context,listen: false);
    // print(widget.uid);
    return Scaffold(
      //  drawer: AppDrawer(),
      //appBar: AppBar(),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 20,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendarAlt),
            label: 'Happenings',
          ),
          // backgroundColor: Colors.pink,
          // ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.images),
            label: 'Gallery',
            // backgroundColor: Colors.green,
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_add_alt_1),
          //   label: 'Add Profile',
          //   //backgroundColor: Colors.yellow,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            //backgroundColor: Colors.yellow,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
