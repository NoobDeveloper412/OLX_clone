import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);
  static const String id = 'email-verification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Email Verification'),
      ),
    );
  }
}
