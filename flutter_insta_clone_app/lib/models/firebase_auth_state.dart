import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_insta_clone_app/utils/simple_snackbar.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  FacebookLogin _facebookLogin;
  // bool initiated = false;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        // if (initiated)
        changeFirebaseAuthStatus();
        // else
        //   initiated = true;
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  // context는 scaffold에서 사용하는 context이어야 한다.
  void registerUser(BuildContext context, {@required String email, @required String password}) {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
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
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
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

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      if (await _facebookLogin.isLoggedIn) {
        await _facebookLogin.logOut();
      }
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

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(context, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        SimpleSnackbar(context, 'User cancel facebook sign in');
        break;
      case FacebookLoginStatus.error:
        SimpleSnackbar(context, '페이스북을 이용한 로그인 중 문제가 발생하였습니다.');
        _facebookLogin.logOut();
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(BuildContext context, String token) async {
    final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token);
    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      SimpleSnackbar(context, '페이스북을 통한 로그인 중 에러가 발생하였습니다. 나중에 다시 시도해주세요.');
    } else {
      _firebaseUser = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
