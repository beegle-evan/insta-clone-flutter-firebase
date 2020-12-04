import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  // context는 scaffold에서 사용하는 context이어야 한다.
  void registerUser(BuildContext context, {@required String email, @required String password}) {
    // trim 메소드를 사용하면, 띄어쓰기가 들어가있어도 정리해준다.
    _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "패스워드를 다시 확인해 주세요.";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "이메일 주소를 다시 확인해 주세요.";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = "이미 사용중인 이메일 주소입니다.";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void login(BuildContext context, {@required String email, @required String password}) {
    _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim()).catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = "이메일 주소를 다시 확인해 주세요.";
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = "비밀번호를 다시 확인해 주세요.";
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = "알수 없는 계정정보 입니다.";
          break;
        case 'ERROR_USER_DISABLED':
          _message = "해당 유저는 접속이 금지 되었습니다.";
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = "너무 많은 요청이 있습니다. 잠시후 다시 시도해주세요.";
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = "허락되지 않은 요청입니다.";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
