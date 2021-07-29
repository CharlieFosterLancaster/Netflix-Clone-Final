import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/home_screen.dart';
import 'package:netflix_clone/screens/profile_screen.dart';
import 'package:netflix_clone/screens/search_content_screen_users.dart';
import 'package:netflix_clone/screens/video_player_screen.dart';
import 'package:netflix_clone/widgets/responsive.dart';

class NavScreen extends StatefulWidget {




  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(key: PageStorageKey('homeScreen')),
    SearchContentScreenUsers(),
    ProfileScreen(),
  ];

  final Map<String, IconData> _icons = const{
    'Home': Icons.home,
    'Search': Icons.search,
    'Profile': Icons.account_box_outlined,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: !Responsive.isDesktop(context) ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _icons.map((title,icon) => MapEntry(
          title, BottomNavigationBarItem(
            icon: Icon(icon, size: 30.0),
          title: Text(title),
        )
        )).values.toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _currentIndex = index),

      ) : null,
    );
  }
}
