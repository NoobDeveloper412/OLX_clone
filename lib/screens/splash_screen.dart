import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/location_screen.dart';
import 'package:olx_clone/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        } else {
          // getUserData();
          Navigator.pushReplacementNamed(context, LocationScreen.id);
        }
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.orange,
      Colors.white,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Horizon',
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Image(
              image: NetworkImage(
                'https://cdn3.iconfinder.com/data/icons/dottie-shopping/24/shopping_048-shopping_cart-strolley-supermarket-express-512.png',
              ),
              height: 100,
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'OLX',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: false,
              onTap: () {
                print("Tap Event");
              },
            )
          ]),
        ));
  }
}
