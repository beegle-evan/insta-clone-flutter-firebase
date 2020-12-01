import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded로 펼치지 않으면, 화면에 보이지 않게됨.
      child: CustomScrollView(
        slivers: <Widget>[
          // 아래 구문은 패턴처럼 사용하면 됨. 리스트와 그리드뷰등을 모아서 동작하는 것을 만들기 위해 sliver를 사용
          SliverList(
            delegate: SliverChildListDelegate([
              _userName(),
              _userBio(),
              _editProfileBtn(),
              _tabButtons(),
              _selectedIndicator(),
            ]),
          ),

          _imagesPager(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _imagesPager() {
    //SliverGrid(delegate: null, gridDelegate: null)
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
        ],
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      // physics는 scroll이 발생했을 때, 어떤 위젯이 그 이벤트를 받아야하는지 헷갈리기 때문에, 이처럼 작성하면 그 이벤트를 받지 않는다
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true, // shrinkWrap을 true로 할 경우, data 갯수에 맞게 GridView크기가 정해진다.
      crossAxisCount: 3,
      childAspectRatio: 1, // child의 가로, 세로 비율을 1:1로 함
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: "https://picsum.photos/id/$index/100/100",
        ),
      ),
    );
  }

  Row _tabButtons() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround, // 클릭할 수 있는 부분이 더 적음, Expanded가 더 넓게 클릭가능
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/grid.png'),
              color: _selectedTab == SelectedTab.left ? Colors.black : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                _selectedTab = SelectedTab.left;
                _leftImagesPageMargin = 0;
                _rightImagesPageMargin = size.width;
              });
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/saved.png'),
              color: _selectedTab == SelectedTab.left ? Colors.black26 : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _selectedTab = SelectedTab.right;
                _leftImagesPageMargin = -size.width;
                _rightImagesPageMargin = 0;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _userName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
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

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: _selectedTab == SelectedTab.left ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }
}

enum SelectedTab { left, right }
