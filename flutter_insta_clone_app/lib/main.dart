import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/material_white.dart';
import 'package:flutter_insta_clone_app/home_page.dart';
import 'package:flutter_insta_clone_app/models/firebase_auth_state.dart';
import 'package:flutter_insta_clone_app/screens/auth_screen.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        // home: AuthScreen(),
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                return AuthScreen();
              case FirebaseAuthStatus.signin:
                return HomePage();
              case FirebaseAuthStatus.progress:
              default:
                return MyProgressIndicator();
            }
          },
          child: HomePage(),
        ),
        theme: ThemeData(
          primarySwatch: white,
        ),
      ),
    );
  }
}
