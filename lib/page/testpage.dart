import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class teststate extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'profile',
              style: TextStyle(fontSize: 24),
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(User.photoURL!),
            )
          ],
        ),
      ),
    );
  }
}
