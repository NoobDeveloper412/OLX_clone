import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:olx_clone/screens/location_screen.dart';
import 'package:olx_clone/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login-screen';
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      } else {
        print('User is signed out.');
      }
    });
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Column(
          children: [
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Image.asset(
                          "assets/images/cart.png",
                          // color: Colors.orange,
                          height: 150,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "OLX",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        )
                      ],
                    ))),
            Expanded(child: Container(child: AuthUI())),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'If you continue, you agree to our Terms and Conditions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )),
          ],
        ));
  }
}
