// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/otp_screen.dart';
import 'package:olx_clone/screens/location_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUser(context, user) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users.doc(user.uid).set({
      'uid': user.uid, // John Doe
      'email': user.email, // Stokes and Sons
      'phoneNumber': user.phoneNumber // 42
    }).then((value) {
      Navigator.pushReplacementNamed(context, LocationScreen.id);
      // ignore: avoid_print, invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  // User? user = FirebaseAuth.instance.currentUser;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Future<void> addUser(context) {
  //   // Call the user's CollectionReference to add a new user
  //   return users.doc(user?.uid).set({
  //     'uid': user!.uid, // John Doe
  //     'mobile': user!.phoneNumber, // Stokes and Sons
  //     'email': user!.email // 42
  //   }).then((value) {
  //     Navigator.pushReplacementNamed(context, LocationScreen.id);
  //     // ignore: avoid_print
  //   }).catchError((error) => print("Failed to add user: $error"));
  // }

  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) async {
      await auth.signInWithCredential(
          authCredential); // After verification is done, sign in the user using the credential.
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // If verification failed, handle it.
      if (authException.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The error is ${authException.code}');
    };

    final PhoneCodeSent codeSent = (String veriId, int? resendToken) async {
      // If otp sent successfully, show the otp dialog.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(
                    number: number,
                    verificationId: veriId,
                  )));
    };
    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (String veriId) {
            // Save the verification id and resend the code
            // after 1 minute.
            print('verification id is $veriId');
          });
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
