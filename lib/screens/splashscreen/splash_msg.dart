import 'package:flutter/material.dart';

import 'splashscreen.dart';

class SplashMessage extends StatefulWidget {
  const SplashMessage({super.key});

  @override
  State<SplashMessage> createState() => _SplashMessageState();
}

class _SplashMessageState extends State<SplashMessage> {
  SplashAuthCheck splashauthcheck = SplashAuthCheck();
  @override
  void initState() {
    super.initState();
    splashauthcheck.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
