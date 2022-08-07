import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/services/phoneAuthService.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);
  static const String id = 'phone-auth-screen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;
  var countryCodeController = TextEditingController(text: "+92");
  var phoneNumberController = TextEditingController();

// Alert Dialog
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: Row(
      children: [
        CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        SizedBox(width: 10),
        Text("Please wait..."),
      ],
    ));
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  // String counterText = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade200,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.red,
                size: 60,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text('Enter your phone number',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text('We will send a confirmation code on your phone.',
                style: TextStyle(color: Colors.grey)),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: countryCodeController,
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: "Country", counterText: "10"),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    flex: 3,
                    child: TextFormField(
                      autofocus: true,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      onChanged: (value) {
                        if (value.length == 10) {
                          setState(() {
                            validate = true;
                          });
                        }
                        if (value.length < 10) {
                          setState(() {
                            validate = false;
                          });
                        }
                      },
                      enabled: true,
                      decoration: InputDecoration(
                          labelText: "Number",
                          // hintText: 'Enter your phone number',

                          hintStyle:
                              TextStyle(fontSize: 10, color: Colors.grey)),
                    )),
              ],
            )
          ],
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
                  String number =
                      '${countryCodeController.text}${phoneNumberController.text}';
                  _service.verifyPhoneNumber(context, number);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

PhoneAuthService _service = PhoneAuthService();
