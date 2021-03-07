import 'package:flutter/material.dart';

class HappeningScreen extends StatelessWidget {
  static String routeName = '/happening-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Happenings'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          OneHappeningCard(
            imageUrl:
                'https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg',
            tilte: 'Solution Challenge DSC OIST',
            subTitle: 'Solution challenge is one the awesome events of dsc',
          ),
          OneHappeningCard(
            imageUrl: 'https://static.toiimg.com/photo/72975551.cms',
            tilte: 'Exam is over!',
            subTitle: 'Let\'s go to home and enjoy our vacations',
          ),
          OneHappeningCard(
            imageUrl:
                'https://s35691.pcdn.co/wp-content/uploads/2020/06/7-things-that-worked.jpg',
            tilte: '4th sem classed from monday',
            subTitle: 'For ofline classed bring your negative corna test',
          )
        ],
      ),
    );
  }
}

class OneHappeningCard extends StatelessWidget {
  final String? imageUrl;
  final String? tilte;
  final String? subTitle;

  const OneHappeningCard({Key? key, this.imageUrl, this.tilte, this.subTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Card(
        elevation: 8.0,
        child: ListTile(
          contentPadding: EdgeInsets.all(12.0),
          leading: Container(
            height: 100.0,
            width: 100.0,
            child: Image.network(
              imageUrl!,
              fit: BoxFit.fill,
            ),
          ),
          title: Text(tilte!),
          subtitle: Text(subTitle!),
        ),
      ),
    );
  }
}
