import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/utils/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black87),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  hintText: 'Email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black87),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black54),
                  hintText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: pass);
                          setState(() {
                            _isSigningIn = false;
                          });
                          Navigator.pushNamed(
                            context,
                            'chat_screen',
                          );
                        } catch (e) {
                          setState(() {
                            _isSigningIn = false;
                          });

                          print(e);

                          ScaffoldMessenger.of(context).showSnackBar(
                            Authentication.customSnackBar(
                              content: e.code.toString(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Log In',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
