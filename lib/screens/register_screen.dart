import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms/screens/login_screen.dart';
import 'package:lms/services/auth_service.dart';

import 'dart:io';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _email;
  String? _password;

  bool _hidePassword = true;
  bool _isLoading = false;

  void _registerUser(BuildContext ctx) async {
    final form = _formKey.currentState!;
    FocusScope.of(context).unfocus();
    if (form.validate()) {
      form.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthServices>(context, listen: false)
            .createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
      }
      //on FirebaseAuthException catch (error) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   // _scaffoldKey.currentState
      //   //     .showSnackBar(SnackBar(content: Text(error.message)));
      //   print('ERROR MESSAGE ${error.message}');
      // }

      on FirebaseAuthException catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error.code);

        if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'Email already in use',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
        if (error.code == 'invalid-emai') {
          _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                'Invalid Email',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } on SocketException catch (error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(
              'Something went wrong, try again!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print('Register Error : $error');
        _scaffoldKey.currentState!.showSnackBar(
          SnackBar(
              content: Text(
                'An unexpected error occured',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent),
        );
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
        title: Text('Register Screen'),
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
                          _registerUser(context);
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
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text('Have an account? Login'),
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

// E/flutter (30026): There are several ways to avoid this problem. The simplest is to use a Builder to get a context that is "under" the Scaffold. For an example of this, please see the documentation for Scaffold.of():
// E/flutter (30026):   https://api.flutter.dev/flutter/material/Scaffold/of.html
// E/flutter (30026): A more efficient solution is to split your build function into several widgets. This introduces a new context from which you can obtain the Scaffold. In this solution, you would have an outer widget that creates the Scaffold populated by instances of your new inner widgets, and then in these inner widgets you would use Scaffold.of().
// E/flutter (30026): A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, then use the key.currentState property to obtain the ScaffoldState rather than using the Scaffold.of() function.
// E/flutter (30026): The context used was:
