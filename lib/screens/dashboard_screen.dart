import 'package:flutter/material.dart';
import 'package:lms/widgets/app_drawer.dart';
import 'package:lms/widgets/dashboard_cards.dart';
import 'package:lms/widgets/todays_lectures.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(255, 203, 0, 1),
      //   onPressed: () {},
      // ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // main-color -
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      //acent-color - backgroundColor: Color.fromRGBO(0, 141, 82, 1),
      //text-color - backgroundColor: Color.fromRGBO(255, 255, 250, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('DashBoard'),
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.notes,
        //   ),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.message,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 7.0),
        ],
      ),
      body: Column(
        children: [
          DashBoardCards(),
          TodaysLectures(),
        ],
      ),
    );
  }
}
