import 'package:animated_textformfields/animated_textformfield/animated_textformfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:olx_clone/services/emailAuthServices.dart';
import 'package:validation_textformfield/validation_textformfield.dart';

class EmailAuthScreen extends StatefulWidget {
  static const String id = 'email-auth-screen';
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreeenState();
}

class _EmailAuthScreeenState extends State<EmailAuthScreen> {
  bool validate = false;
  final _formKey = GlobalKey<FormState>();
  bool _login = false;
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final EmailAuthentication _services = EmailAuthentication();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  _validateEmail() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        validate = false;
        _loading = true;
      });
      _services
          .getAdminCredentials(
        context: context,
        isLog: _login,
        password: _passwordController.text,
        email: _emailController.text,
      )
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: Column(
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
                        height: 12,
                      ),
                      Text(_login ? "Login" : "Signup",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Enter your Email and Password to ${_login ? "Login" : "Signup"}.',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              // AnimatedTextFormField(
              //   cursorColor: Colors.orange,
              //   backgroundColor: Colors.grey.shade100, hintText: "Email",
              //   controller: _emailController,

              //   validator: (value) {
              //     final bool isValid =
              //         EmailValidator.validate(_emailController.text);
              //     if (value.isEmpty) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //             content: Text('Please enter a valid email!')),
              //       );
              //     }
              //     if (value.isNotEmpty && isValid == false) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //             content: Text('Please enter a valid email!')),
              //       );
              //     }
              //     return null;
              //   },

              //   focusNode: emailFocusNode,
              //   width: MediaQuery.of(context).size.width * 0.875,

              //   // decoration: InputDecoration(
              //   //   contentPadding: const EdgeInsets.only(left: 10),
              //   //   labelText: 'Email',
              //   //   filled: true,
              //   //   fillColor: Colors.grey.shade300,
              //   //   border: OutlineInputBorder(
              //   //     borderRadius: BorderRadius.circular(2),
              //   //   ),
              //   // ),
              // ),
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
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14.0)),
                textEditingController: _emailController,
              ),

              const SizedBox(
                height: 10,
              ),
              PassWordValidationTextFiled(
                decoration: const InputDecoration(
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14.0)),
                cursorColor: Colors.orange,
                lineIndicator: false,
                passwordMinError: "Must be more than 5 character",
                hasPasswordEmpty: "Password is Empty",
                passwordMaxError: "Password is too long",
                passwordMaxLength: 25,
                passWordUpperCaseError: "Use at least one capital letter",
                passWordDigitsCaseError: "Use at least one digit",
                passwordLowercaseError: "Use at least one lowercase character",
                obscureText: true,
                scrollPadding: EdgeInsets.only(left: 60),
                onChanged: (value) {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    if (value.length >= 5) {
                      setState(() {
                        validate = true;
                      });
                    } else {
                      setState(() {
                        validate = false;
                      });
                    }
                  }
                },
                passTextEditingController: _passwordController,
                passwordMinLength: 5,
              ),
              // AnimatedTextFormField(
              //   cursorColor: Colors.orange,
              //   backgroundColor: Colors.grey.shade100,
              //   hintText: "Password",

              //   controller: _passwordController,
              //   // decoration: InputDecoration(
              //   //   contentPadding: const EdgeInsets.only(left: 10),
              //   //   labelText: 'Password',
              //   //   suffixIcon: validate
              //   //       ? IconButton(
              //   //           icon: Icon(Icons.clear),
              //   //           onPressed: () {
              //   //             setState(() {
              //   //               _passwordController.clear();
              //   //               validate = false;
              //   //             });
              //   //           },
              //   //         )
              //   //       : null,
              //   //   filled: true,
              //   //   fillColor: Colors.grey.shade300,
              //   //   border: OutlineInputBorder(
              //   //     borderRadius: BorderRadius.circular(2),
              //   //   ),
              //   // ),
              //   width: MediaQuery.of(context).size.width * 0.875,
              //   height: 48.0,

              //   focusNode: passwordFocusNode,
              // ),

              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(_login ? 'New to OLX?' : 'Already have an account?'),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _login = !_login;
                        });
                      },
                      child: Text(
                        _login ? "Signup" : "Login",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: validate ? false : true,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: validate
                        ? MaterialStateProperty.all(
                            Theme.of(context).primaryColor)
                        : MaterialStateProperty.all(Colors.grey)),
                onPressed: () {
                  _validateEmail();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _loading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ),
                        )
                      : Text(
                          _login ? "Login" : "Signup",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                )),
          ),
        ),
      ),
    );
  }
}
