import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/otp_screen.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';
import 'package:olx_clone/screens/location_screen.dart';
import 'package:olx_clone/screens/login_screen.dart';
import 'package:olx_clone/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: Colors.orange, fontFamily: 'Lato'),
              home: LoginScreen(),
              // home: OTPScreen(
              //   number: '03036175724',
              //   verificationId: 'veriId',
              // ),
              // Initial Routing is not working for some reason
              routes: {
                LoginScreen.id: (context) => LoginScreen(),
                PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
                LocationScreen.id: (context) => LocationScreen(),
              },
            );
          }
        });
  }
}
