import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/widgets/fadestack.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

const int selectedFormTypeSignUp = 0;
const int selectedFormTypeSignIn = 1;

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = selectedFormTypeSignUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FadeStack(
              selectedForm: selectedForm,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 40,
              child: Container(
                color: Colors.white,
                child: FlatButton(
                  shape: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      if (selectedForm == selectedFormTypeSignUp) {
                        selectedForm = selectedFormTypeSignIn;
                      } else {
                        selectedForm = selectedFormTypeSignUp;
                      }
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: (selectedForm == selectedFormTypeSignUp)
                          ? "Already have an account?   "
                          : "Don't have an account?   ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: (selectedForm == selectedFormTypeSignUp) ? "Sign In " : "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
