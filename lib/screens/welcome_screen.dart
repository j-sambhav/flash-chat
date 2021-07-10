import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flash_chat/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static const id = 'welcome_screen';
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;
  @override
  void initState() {
    Authentication.initializeFirebase();
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = ColorTween(begin: Colors.blueGrey.shade200, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      }
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    //reverse bhi ja sakta h
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSigningIn,
      child: Scaffold(
        backgroundColor: animation.value,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                  Container(
                      child:
                          AnimatedTextKit(repeatForever: true, animatedTexts: [
                    ColorizeAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 45.0,
                          color: Colors.blueGrey.shade600,
                          fontFamily: 'PressStart2P'),
                      colors: [
                        Colors.black87,
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                    )
                  ]))
                ],
              ),
            ),
            SizedBox(height: 80),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login_screen');
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
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
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
            SizedBox(
              height: 30,
            ),
            SignInButton(
              Buttons.GoogleDark,
              padding: EdgeInsets.symmetric(horizontal: double.minPositive),
              text: "Sign In with Google",
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  print(user.displayName);
                  Navigator.pushNamed(context, 'chat_screen');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
