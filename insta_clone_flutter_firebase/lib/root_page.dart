import 'package:flutter/material.dart';
import 'package:instaflutter/login_page.dart';
import 'package:instaflutter/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // 데이터가 있을때
          return TabPage(snapshot.data);
        } else {
          // 데이터가 없을때
          return LoginPage();
        }
      },
    );
  }
}
