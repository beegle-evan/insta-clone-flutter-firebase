import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/feed_screen.dart';

// stateless widget을 stateful widget으로 변경하는데, 간단히 바꾸는것은 옵션+엔터 단축키로 바꾸는 것이다.
// 옵셥 + 엔터 하면, stateful widget으로 변경하는 옵션이 나온다.
class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  int _selectedIndex = 0;

  List<Widget> _screens = <Widget>[
    // Command + d 단축키로 아래로 반복 복사를 할 수 있다
    FeedScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepPurpleAccent),
    Container(color: Colors.cyanAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body에 _screens를 그냥 넣으면, 복잡한 화면일때 항상 새로 다시 그리면서, 불필요한 작업이 많은 문제가 발생한다.
      // 이를 수정하기 위해, IndexedStack을 사
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
