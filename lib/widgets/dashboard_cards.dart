import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/widgets/onecard.dart';

class DashBoardCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              childAspectRatio: 1.28,
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              crossAxisCount: 2,
              children: [
                OneCard(
                  title: 'Announcements',
                  icon: FontAwesomeIcons.bell,
                  count: 11,
                ),
                OneCard(
                  title: 'Attendence',
                  icon: FontAwesomeIcons.calendarCheck,
                  count: 57,
                ),
                OneCard(
                  title: 'Assignments',
                  icon: FontAwesomeIcons.clipboardList,
                  count: 5,
                ),
                OneCard(
                  title: 'Inventory',
                  icon: FontAwesomeIcons.watchmanMonitoring,
                  count: 1,
                  onTap: () {},
                  // onTap: () =>
                  //     Navigator.pushNamed(context, LeactureScreeen.routeName),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
