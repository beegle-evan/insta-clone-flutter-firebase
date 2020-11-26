import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      home: HomePage(),
    );
  }
}
