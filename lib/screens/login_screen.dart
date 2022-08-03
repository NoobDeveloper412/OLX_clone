import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:olx_clone/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Column(
          children: [
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 100),
                        Image.network(
                          "https://cdn3.iconfinder.com/data/icons/dottie-shopping/24/shopping_048-shopping_cart-strolley-supermarket-express-512.png",
                          color: Colors.orange,
                          height: 80,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Buy or Sell",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        )
                      ],
                    ))),
            Expanded(child: Container(child: AuthUI())),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'If you continue, you agree to our Terms and Conditions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )),
          ],
        ));
  }
}
