import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:olx_clone/screens/location_screen.dart';
import 'package:olx_clone/widgets/auth_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }
    });
    return WillPopScope(
      // onWillPop: () {
      //   return Future.value(false);
      // },
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure you want to exit?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
        // return false;
      },
      child: Scaffold(
          backgroundColor: Colors.orange,
          body: Column(
            children: [
              Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Image.asset(
                            "assets/images/cart.png",
                            // color: Colors.orange,
                            height: 150,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "OLX",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          )
                        ],
                      ))),
              const Expanded(child: AuthUI()),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'If you continue, you agree to our Terms and Conditions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )),
            ],
          )),
    );
  }
}
