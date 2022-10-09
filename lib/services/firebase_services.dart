import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_clone/screens/home_screen.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateUser(Map<String, dynamic> data, context) {
    return users.doc(user!.uid).update(data).then((value) {
      Navigator.pushNamed(context, HomeScreen.id);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update the locat.'),
      ));
    });
  }
}
