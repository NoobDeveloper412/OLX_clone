// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:olx_clone/screens/authentication/emailAuthScreen.dart';
import 'package:olx_clone/screens/authentication/emailVerificationScreen.dart';
import 'package:olx_clone/screens/authentication/google_auth.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';
import 'package:olx_clone/services/phoneAuthService.dart';

class AuthUI extends StatelessWidget {
  const AuthUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, PhoneAuthScreen.id);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.phone_android_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text('Continue with Phone',
                      style: TextStyle(color: Colors.black)),
                ],
              )),
        ),
        SizedBox(
          height: 5,
        ),
        SignInButton(
          Buttons.Google,
          text: "Sign up with Google",
          onPressed: () async {
            User? user =
                await GoogleAuthentication.signInWithGoogle(context: context);
            if (user != null) {
              PhoneAuthService _authentication = PhoneAuthService();
              // ignore: use_build_context_synchronously
              _authentication.addUser(context, user, user.uid);
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, EmailAuthScreen.id);
            Navigator.pushNamed(context, EmailVerificationScreen.id);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.white,
            ))),
            child: Text(
              'Login with Email',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
      ],
    ));
  }
}
