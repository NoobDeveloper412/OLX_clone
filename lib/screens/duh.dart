import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DUH extends StatefulWidget {
  const DUH({Key? key}) : super(key: key);

  @override
  State<DUH> createState() => _DUHState();
}

class _DUHState extends State<DUH> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(user!.uid),
      ),
    );
  }
}
