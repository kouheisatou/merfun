import 'package:flutter/material.dart';
import 'package:frontend/view/detail_page.dart';
import 'package:frontend/view/item_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent BottomNavigationBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _pages = [
    TabNavigator(navigatorKey: GlobalKey<NavigatorState>(), pageIndex: 0),
    TabNavigator(navigatorKey: GlobalKey<NavigatorState>(), pageIndex: 1),
    TabNavigator(navigatorKey: GlobalKey<NavigatorState>(), pageIndex: 2),
    TabNavigator(navigatorKey: GlobalKey<NavigatorState>(), pageIndex: 3),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      // 現在のタブのナビゲーターでポップ
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _pages.asMap().entries.map((entry) {
          int index = entry.key;
          Widget page = entry.value;
          return Offstage(
            offstage: _currentIndex != index,
            child: page,
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'プロフィール',
          ),
        ],
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int pageIndex;

  const TabNavigator({
    required this.navigatorKey,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/details':
            page = DetailPage(ticketId: settings.arguments as String);
            break;
          default:
            page = ItemsListPage();
        }
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
