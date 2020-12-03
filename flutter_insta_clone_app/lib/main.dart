import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/material_white.dart';
import 'package:flutter_insta_clone_app/home_page.dart';
import 'package:flutter_insta_clone_app/screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      // home: AuthScreen(),
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: white,
      ),
    );
  }
}
