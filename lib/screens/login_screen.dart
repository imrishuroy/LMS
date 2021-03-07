import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _email;
  String? _password;

  bool _hidePassword = true;
  bool _isLoading = false;

  void _login() async {
    final form = _formKey.currentState!;
    FocusScope.of(context).unfocus();
    if (form.validate()) {
      form.save();
      try {
        setState(() {
          _isLoading = true;
        });
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        // print(userCredential);
        Navigator.pushReplacementNamed(context, '/');
        if (userCredential != null) {
          //Navigator.pushReplacementNamed(context, SuccusScreen.routeName);
          // Navigator.pushNamed(context, SuccusScreen.routeName);
        }
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        if (error.code == 'user-not-found') {
          print('No user found for that email.');
          _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'User not found',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        if (error.code == 'wrong-password') {
          _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'Wrong password',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          elevation: 10.0,
          //   color: Colors.yellow,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 15.0,
                      ),
                      child: TextFormField(
                        key: ValueKey('email'),
                        onSaved: (value) => _email = value,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) => !(value!.contains('@gmail.com'))
                            ? 'Invalid Email'
                            : null,
                        decoration: InputDecoration(
                          //icon: Icon(Icons.mail),
                          prefixIcon: Icon(Icons.mail),
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 15.0,
                      ),
                      child: TextFormField(
                        key: ValueKey('password'),
                        onSaved: (value) => _password = value,
                        obscureText: _hidePassword,
                        controller: _passwordController,
                        validator: (value) =>
                            value!.length < 6 ? 'Password too short' : null,
                        decoration: InputDecoration(
                          // icon: Icon(Icons.lock),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                    if (!_isLoading)
                      RaisedButton(
                        color: Color.fromRGBO(0, 141, 82, 1),
                        onPressed: () {
                          _login();
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    if (!_isLoading)
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Create a new account'),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
