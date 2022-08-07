import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';
import 'package:olx_clone/screens/location_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String number, verificationId;

  OTPScreen({required this.number, required this.verificationId});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _loading = false;
  String error = '';

  TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  Future<void> phoneCredentials(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        // Signin
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      } else {
        print("Login failed.");
        if (mounted) {
          setState(() {
            error = 'Login failed.';
          });
        }
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      if (mounted) {
        setState(() {
          error = 'Invalid OTP.';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var onTapRecognizer;

    StreamController<ErrorAnimationType> errorController =
        StreamController<ErrorAnimationType>();
    bool hasError = false;

    @override
    void initState() {
      onTapRecognizer = TapGestureRecognizer()
        ..onTap = () {
          Navigator.pop(context);
        };
      errorController = StreamController<ErrorAnimationType>();
      super.initState();
    }

    @override
    void dispose() {
      errorController.close();

      super.dispose();
    }

    final node = FocusScope.of(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: const Text(
              'Login',
              style: TextStyle(color: Colors.orange),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red.shade200,
                  child: const Icon(
                    CupertinoIcons.person_alt_circle,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'We sent a 6-digit code to your phone number.',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          children: [
                            TextSpan(
                                text: widget.number,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                          // Sending the user back to the auth screen as i was not able to pop the context
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PhoneAuthScreen()));
                        },
                        child: const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                PinCodeTextField(
                  appContext: context,
                  onCompleted: (v) {
                    phoneCredentials(context, v);
                    debugPrint(v);
                    setState(() {
                      _loading = true;
                    });
                  },
                  onChanged: (value) {
                    if (value.length != 6) {
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 2) {
                      return "Please enter the OTP.";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: hasError ? Colors.red : Colors.orange,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20, height: 1.6),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  errorAnimationController:
                      errorController, // This will shake the pin code field
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],

                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
                if (_loading)
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 50,
                      // height: 100,
                      child: LinearProgressIndicator(
                        // value: ,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          ),
        ));
  }
}
