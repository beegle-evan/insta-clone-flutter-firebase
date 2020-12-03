import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/auth_input_decor.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/home_page.dart';
import 'package:flutter_insta_clone_app/widgets/or_divider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세요.';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecor('Password'),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return '비밀번호를 다시 확인해주세요.';
                  }
                },
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                onPressed: () {},
                textColor: Colors.blue,
                icon: ImageIcon(
                  AssetImage('assets/images/facebook.png'),
                ),
                label: Text('login witth Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // TextFormField에서, validator의 체크 후, return null이 오는 경우, 이 조건문은 true가 된다.
          print('Validation success!!');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(common_s_gap),
      ),
    );
  }
}
