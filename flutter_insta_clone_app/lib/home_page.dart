import 'package:flutter/material.dart';

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
    Container(color: Colors.amberAccent), // Command + d 단축키로 아래로 반복 복사를 할 수 있다
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepPurpleAccent),
    Container(color: Colors.cyanAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: btmNavItems,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black87,
            currentIndex: _selectedIndex,
            onTap: _onBtmItemClick,
          ),
        ));
  }

  void _onBtmItemClick(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
