import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          body: Container(
            color: Colors.amberAccent,
          ),
          bottomNavigationBar: BottomNavigationBar(
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
  }
}
