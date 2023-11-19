import 'package:flutter/material.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/screens/splashscreen/splash_msg.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashMessage(),
    );
  }
}
