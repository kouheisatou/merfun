import 'package:flutter/material.dart';
import 'package:frontend/view/ticket_detail_page.dart';
import 'package:frontend/view/ticket_list_page.dart';
import 'package:openapi/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.red,
        ),
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
      bottomNavigationBar: Container(
        color: Colors.white,
        width: double.infinity,
        height: 70,
        child: Stack(
          children: [
            Image.asset("images/bottom_tab_bar.jpeg"),
            Positioned(
              child: InkWell(
                splashColor: Colors.red.withOpacity(0.3),
                highlightColor: Colors.red.withOpacity(0.1),
                onTap: () {},
                child: Container(
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Positioned(
              left: 64,
              top: 5,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 55,
                  height: 55,
                  child: Image.asset("images/ticket_icon.png"),
                ),
              ),
            )
          ],
        ),
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
            page = TicketDetailPage(ticket: settings.arguments as Ticket);
            break;
          default:
            page = TicketListPage();
        }
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
