import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/otp_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OTPScreen(number: number)));
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
}
