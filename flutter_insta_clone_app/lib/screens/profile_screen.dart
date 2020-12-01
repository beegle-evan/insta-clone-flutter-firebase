import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appbar(),
            Expanded(
              // Expanded로 펼치지 않으면, 화면에 보이지 않게됨.
              child: CustomScrollView(
                slivers: <Widget>[
                  // 아래 구문은 패턴처럼 사용하면 됨. 리스트와 그리드뷰등을 모아서 동작하는 것을 만들기 위해 sliver를 사용
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _username(),
                      _userbio(),
                      _editProfileBtn(),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: OutlineButton(
        onPressed: () {},
        borderSide: BorderSide(color: Colors.black45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        // Expanded로 묶으면, IconButton이 자리 차지하고, 나머지를 Text가 다 차지함.
        Expanded(
          child: Text(
            'The Coding Papa',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userbio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'this is what I believe!!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}
