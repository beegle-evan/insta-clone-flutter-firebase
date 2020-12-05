import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/material_white.dart';
import 'package:flutter_insta_clone_app/home_page.dart';
import 'package:flutter_insta_clone_app/models/firebase_auth_state.dart';
import 'package:flutter_insta_clone_app/models/user_model_state.dart';
import 'package:flutter_insta_clone_app/repo/user_network_repository.dart';
import 'package:flutter_insta_clone_app/screens/auth_screen.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(create: (_) => UserModelState()),
      ],
      child: MaterialApp(
        // home: AuthScreen(),
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _clearUserModel(context);
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _initUserModel(firebaseAuthState, context);
                _currentWidget = HomePage();
                break;
              case FirebaseAuthStatus.progress:
              default:
                _currentWidget = MyProgressIndicator();
            }
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _currentWidget,
            );
          },
        ),
        theme: ThemeData(
          primarySwatch: white,
        ),
      ),
    );
  }

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);

    userModelState.currentStreamSub =
        userNetworkRepository.getUserModelStream(firebaseAuthState.firebaseUser.uid).listen((userModel) {
      Provider.of<UserModelState>(context, listen: false).userModel =
          userModel; // UserModel 안에 notifyListener가 호출되므로, listen:false를 호출해줘야함.
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
