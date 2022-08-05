import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/phoneAuthScreen.dart';
import 'package:olx_clone/screens/login_screen.dart';
import 'package:olx_clone/screens/splash_screen.dart';

void main() {
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
              initialRoute: LoginScreen.id,
              routes: {
                LoginScreen.id: (context) => LoginScreen(),
                PhoneAuthScreen.id: (context) => PhoneAuthScreen()
              },
            );
          }
        });
  }
}
