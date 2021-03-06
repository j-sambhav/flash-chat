import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/utils/authentication.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isSigningIn = false;
  String email;
  String pass;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSigningIn,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
                onChanged: (value) {
                  pass = value;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(),
                child: Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            _isSigningIn = true;
                          });
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: pass);
                          User user = newUser.user;
                          setState(() {
                            _isSigningIn = false;
                          });
                          Navigator.pushNamed(context, 'chat_screen');
                        } catch (e) {
                          setState(() {
                            _isSigningIn = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            Authentication.customSnackBar(
                              content: e.code.toString(),
                            ),
                          );
                          print(e);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Register',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
