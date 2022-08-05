import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);
  static const String id = 'phone-auth-screen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  var countryCodeController = TextEditingController(text: "+92");
  var phoneNumberController = TextEditingController();

  String counterText = '0';
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
                        // onChanged: (value) {
                        //   setState(() {
                        //     counterText = value.length.toString();
                        //   });
                        // },
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
        ));
  }
}
