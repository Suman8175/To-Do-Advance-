import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/screens/auth/login_screen.dart';
import 'package:todos/screens/homepage.dart';

class SplashAuthCheck {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checkAuth(BuildContext context) {
    if (_auth.currentUser != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      );
    }
  }
}
