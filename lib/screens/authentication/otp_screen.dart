import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  OTPScreen({required this.number});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome Back",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'We sent a 6-digit code to your phone number.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      children: [
                        TextSpan(
                            text: widget.number,
                            style: TextStyle(
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
                              builder: (context) => PhoneAuthScreen()));
                    },
                    child: Icon(Icons.edit))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
