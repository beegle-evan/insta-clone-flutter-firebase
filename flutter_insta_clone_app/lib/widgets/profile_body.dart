import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool selectedLeft = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded로 펼치지 않으면, 화면에 보이지 않게됨.
      child: CustomScrollView(
        slivers: <Widget>[
          // 아래 구문은 패턴처럼 사용하면 됨. 리스트와 그리드뷰등을 모아서 동작하는 것을 만들기 위해 sliver를 사용
          SliverList(
            delegate: SliverChildListDelegate([
              _username(),
              _userbio(),
              _editProfileBtn(),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround, // 클릭할 수 있는 부분이 더 적음, Expanded가 더 넓게 클릭가능
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: ImageIcon(
                        AssetImage('assets/images/grid.png'),
                        color: selectedLeft ? Colors.black : Colors.black26,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedLeft = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: ImageIcon(
                        AssetImage('assets/images/saved.png'),
                        color: selectedLeft ? Colors.black26 : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedLeft = false;
                        });
                      },
                    ),
                  ),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
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
}
