import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';
import 'package:olx_clone/screens/location_screen.dart';

class OTPScreen extends StatefulWidget {
  final String number, verificationId;

  OTPScreen({required this.number, required this.verificationId});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _loading = false;
  String error = '';
  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();

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
                                builder: (context) => const PhoneAuthScreen()));
                      },
                      child: const Icon(Icons.edit))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _text1,
                      maxLength: 1,
                      // style: Decoration(),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text2,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text3,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text4,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text5,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          node.nextFocus();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _text6,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) {
                        if (value.length == 1) {
                          // node.nextFocus();
                          if (value.length == 1) {
                            if (_text1.text.length == 1) {
                              if (_text2.text.length == 1) {
                                if (_text3.text.length == 1) {
                                  if (_text4.text.length == 1) {
                                    if (_text5.text.length == 1) {
                                      if (_text6.text.length == 1) {
                                        String otp =
                                            '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                        setState(() {
                                          _loading = true;
                                        });
                                        // Login
                                        phoneCredentials(context, otp);
                                      }
                                    }
                                  }
                                }
                              }
                            } else {
                              setState(() {
                                _loading = false;
                              });
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
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
      ),
    );
  }
}
