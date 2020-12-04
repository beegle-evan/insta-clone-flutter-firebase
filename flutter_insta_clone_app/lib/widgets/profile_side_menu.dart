import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/models/firebase_auth_state.dart';
import 'package:flutter_insta_clone_app/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  const ProfileSideMenu(
    this.menuWidth, {
    Key key,
  }) : super(key: key); // { } 안에 있으면 옵션값인데, 밖으로 빼면 꼭 넣어줘야 하는 값이 됨

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black87,
              ),
              title: Text('Sign out'),
              onTap: () {
                Provider.of<FirebaseAuthState>(context, listen: false).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
