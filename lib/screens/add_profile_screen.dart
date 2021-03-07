import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

import 'package:lms/services/database_service.dart';

class AddProfileScreen extends StatefulWidget {
  static String routeName = '/add-profile_screen';
  final DataBase? database;

  const AddProfileScreen({Key? key, this.database}) : super(key: key);
  // final String? uid;

  // AddProfileScreen(this.uid);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AddProfileScreen> {
  CollectionReference? usersRef =
      FirebaseFirestore.instance.collection('users');

  // String documentId() => DateTime.now().toIso8601String();
  final _formKey = GlobalKey<FormState>();
  // final CollectionReference users =
  //     FirebaseFirestore.instance.collection('userImages');
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // final auth = FirebaseAuth.instance;

  File? _image;
  final ImagePicker? picker = ImagePicker();
  String? _name;
  String? _fatherName;
  String? _motherName;
  String? _mobileNo;

  bool _isSubmiting = false;

  void _submit(BuildContext context) async {
    final form = _formKey.currentState!;
    // final database = Provider.of<DataBase>(context, listen: false);
    print('printting databse id ${widget.database?.id}');
    FocusScope.of(context).unfocus();
    if (form.validate()) {
      if (_image == null) {
        // _scaffoldKey.currentState!.showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       'Select a image for upload',
        //       textAlign: TextAlign.center,
        //     ),
        //     backgroundColor: Colors.redAccent,
        //   ),
        // );
      } else {
        form.save();
        setState(() {
          _isSubmiting = true;
        });

        await widget.database
            ?.setData(
                name: _name,
                fatherName: _fatherName,
                motherName: _motherName,
                mobileNo: _mobileNo,
                image: _image,
                documentId: widget.database?.id)
            .then(
              (value) => Navigator.of(context).pop(),
            );
        // .then((value) => Navigator.of(context).pop());

      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker?.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthServices>(context, listen: false);
    // final database = Provider.of<DataBase>(context, listen: false);
    return Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Your Profile'),
          backgroundColor: Color.fromRGBO(0, 141, 82, 1),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: _image == null ? null : FileImage(_image!),
                  child: _image == null
                      ? IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30.0,
                          ),
                          onPressed: () => _pickImage(),
                        )
                      : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 27.0,
                        color: Colors.white,
                      ),
                      onPressed: _image != null ? () => _pickImage() : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _isSubmiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          key: ValueKey('name'),
                          onSaved: (value) => _name = value,
                          keyboardType: TextInputType.name,
                          // controller: _emailController,
                          validator: (value) =>
                              !(value!.length >= 3) ? 'Invalid Input' : null,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.mail),
                            labelText: 'Your Name',
                            hintText: 'Enter your full name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          key: ValueKey('fathers-name'),
                          onSaved: (value) => _fatherName = value,
                          keyboardType: TextInputType.name,
                          // controller: _emailController,
                          validator: (value) =>
                              !(value!.length >= 3) ? 'Invalid Input' : null,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.mail),
                            labelText: 'Father\'s Name',
                            hintText: 'Enter your father name.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          key: ValueKey('mothers-name'),
                          onSaved: (value) => _motherName = value,
                          keyboardType: TextInputType.name,
                          // controller: _emailController,
                          validator: (value) =>
                              !(value!.length >= 3) ? 'Invalid Input' : null,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.mail),
                            labelText: 'Mother\'s Name',
                            hintText: 'Enter your mother name.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        child: TextFormField(
                          key: ValueKey('phone-no'),
                          onSaved: (value) => _mobileNo = value,
                          keyboardType: TextInputType.name,
                          // controller: _emailController,
                          validator: (value) =>
                              !(value!.length >= 10) ? 'Invalid Input' : null,
                          decoration: InputDecoration(
                            //icon: Icon(Icons.mail),
                            labelText: 'Moblie No.',
                            hintText: 'Enter your mobile number.',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: () {
                            _submit(context);
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
        // : UserProfile(
        //     dataBase: database,
        //   ),
        // : Container(),
        );
  }
}

// SizedBox(height: 20.0),
// isOpen
//     ? CircleAvatar(
//         backgroundColor: Colors.white,
//         // backgroundImage:
//         //     _image != null ? FileImage(_image) : null,
//         child: GestureDetector(
//           onTap: _pickImage,
//           child: _image == null
//               ? Icon(
//                   Icons.camera_alt,
//                   size: 40.0,
//                   color: Colors.green,
//                 )
//               : null,
//         ),
//         radius: 60.0,
//       )
//     : UserImage(),
// Container(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: 10,
//       vertical: 5,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         IconButton(
//           icon: Icon(
//             Icons.edit,
//             size: 27.0,
//             color: Colors.white,
//           ),
//           // onPressed: _showBottomSheat,
//           onPressed: () {
//             setState(() {
//               isOpen = !isOpen;
//             });
//           },
//         ),
//       ],
//     ),
//   ),
// ),
// SizedBox(height: 40.0)

// bottom: PreferredSize(
//   preferredSize: Size.fromHeight(180),
//   child: FutureBuilder<DocumentSnapshot>(
//     future: users.doc(auth.currentUser.uid).get(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Center(
//           child: Text('Something went wrong'),
//         );
//       }
//       if (snapshot.connectionState == ConnectionState.done) {
//         Map data = snapshot.data.data();
//         print('User data $data');
//         final userImage = data['image_url'];
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 45.0,
//                 backgroundImage:
//                     userImage != null ? NetworkImage(userImage) : null,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Text(
//               'Nikhil Tripathi',
//               style: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 1.2,
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Text(
//               '0105CS191076',
//               style: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 1.2,
//               ),
//             ),
//             Text(
//               'P239-10976',
//               style: TextStyle(
//                 color: Colors.white,
//                 letterSpacing: 1.2,
//               ),
//             ),
//             SizedBox(height: 30),
//           ],
//         );
//       }
//       return CircularProgressIndicator();
//     },
//   ),
// ),
