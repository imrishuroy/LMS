import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lms/widgets/one_gallery_card.dart';

class GalleryScreen extends StatelessWidget {
  final CollectionReference? /*!*/ gallery =
      FirebaseFirestore.instance.collection('gallery');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gallery'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: gallery?.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Some thing went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // important
            QuerySnapshot? querySnapshot = snapshot.data;

            return Column(
              children: [
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white24,
                      filled: true,
                      hintText: 'What are you looking for?',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.green,
                            size: 40.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                //  SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OneGalleryCard(
                        color: Color(0xffffa45b),
                        label: 'Campus',
                        icon: Icons.apartment,
                      ),
                      OneGalleryCard(
                        color: Color(0xff65d6ce),
                        label: 'Cantein',
                        icon: Icons.food_bank,
                      ),
                      OneGalleryCard(
                        color: Color(0xffb6eb7a),
                        label: 'Classes',
                        icon: Icons.group_sharp,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OneGalleryCard(
                        color: Color(0xffffb0cd),
                        label: 'Lab',
                      ),
                      OneGalleryCard(
                        color: Color(
                          0xffed6663,
                        ),
                        icon: Icons.workspaces_outline,
                        label: 'Workspaces',
                      ),
                      OneGalleryCard(
                        color: Color(0xff5edfff),
                        icon: Icons.more_vert,
                        label: 'More',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: snapshot.data?.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final imageUrl = snapshot.data?.docs[index]['imageUrl'];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            '$imageUrl',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                )

                // Expanded(
                //   child: ListView(
                //     children: snapshot.data.docs.map((DocumentSnapshot doc) {
                //       return Image.network('${doc.data()['image_url']}');
                //     }).toList(),
                //   ),
                // )
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: querySnapshot?.size,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         height: 200,
                //         width: 100,
                //         child: Image.network(
                //           '${querySnapshot?.docs[index]['imageUrl']}',
                //         ),
                //       );
                //     },
                //   ),
                // )
              ],
            );
          }),
    );
  }
}
