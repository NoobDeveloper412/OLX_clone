// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {},
              child: Row(
                children: [
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
        SignInButton(
          Buttons.Google,
          text: "Sign up with Google",
          onPressed: () {},
        ),
        SignInButton(
          Buttons.FacebookNew,
          text: "Sign up with Google",
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Login with Email',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    ));
  }
}
