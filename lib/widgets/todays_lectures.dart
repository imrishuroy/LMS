import 'package:flutter/material.dart';
import 'package:lms/data/app_data.dart';

class TodaysLectures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              'Todays Lectures',
              style: TextStyle(
                fontSize: 19.9,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Color.fromRGBO(255, 203, 0, 1),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: lectures.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 7.0),
                  child: Card(
                    color: Color.fromRGBO(255, 255, 250, 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${lectures[index]['sub-code']}'),
                          Text(
                            '${lectures[index]['lecture']}',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Text('${lectures[index]['room']}')
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
