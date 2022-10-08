import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/authentication/emailVerificationScreen.dart';
import 'package:olx_clone/screens/location_screen.dart';

class EmailAuthentication {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<Object> getAdminCredentials({context, isLog, password, email}) async {
    DocumentSnapshot result = await users.doc(email).get();
    if (isLog) {
      emailLogin(email, password, context);
    } else {
      if (result.exists) {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User already exists!')),
        );
      } else {
        emailSignup(email, password, context);
      }
    }
    return result;
  }

  emailLogin(email, password, context) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, LocationScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials provided.')),
        );
      }
    }
  }

  emailSignup(email, password, buildContext) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user?.uid != null) {
        return users.doc(credential.user!.email).set({
          'email': credential.user!.email,
          'uid': credential.user!.uid,
          'phoneNumber': null,
        }).then((value) async {
          // Verifying before redirecting to the locationScreen
          await credential.user!.sendEmailVerification().then((value) {
            Navigator.pushReplacementNamed(
                buildContext, EmailVerificationScreen.id);
          });
        }).catchError((onError) {
          ScaffoldMessenger.of(buildContext).showSnackBar(
            const SnackBar(content: Text('Error occured!')),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(buildContext).showSnackBar(
          const SnackBar(content: Text('The password is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(buildContext).showSnackBar(
          const SnackBar(content: Text('Account already in use!')),
        );
      }
    } catch (e) {
      return ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
