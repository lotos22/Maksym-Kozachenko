import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListRestoraunts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text('logout'),
        ),
      ),
    );
  }
}
