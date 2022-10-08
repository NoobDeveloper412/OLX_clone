import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/emailAuthScreen.dart';
import 'package:validation_textformfield/validation_textformfield.dart';

class PasswordResetScreen extends StatelessWidget {
  static const String id = 'password-reset-screen';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                  size: 75,
                ),
                Text('Forgot\npassword?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Type your email, we'll send a verification code.",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                EmailValidationTextField(
                  whenTextFieldEmpty: "Please enter an email",
                  cursorColor: Colors.orange,
                  validatorMassage: "Please enter a valid email",
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      border: OutlineInputBorder(),
                      counterText: '',
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Colors.black, fontSize: 14.0)),
                  textEditingController: _emailController,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('Send Code'),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then((value) {
              Navigator.pushReplacementNamed(context, EmailAuthScreen.id);
            });
          }
        },
      ),
    );
  }
}
