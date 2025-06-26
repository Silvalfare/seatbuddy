import 'package:flutter/material.dart';
import 'package:seatbuddy/screen/content.dart';
import 'package:seatbuddy/screen/history.dart';
import 'package:seatbuddy/screen/notifications.dart';
import 'package:seatbuddy/screen/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screen = [
    ContentScreen(),
    NotificationsScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: _screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 2,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        unselectedLabelStyle: TextStyle(
          color: Color(0xff5E5E5E),
          fontSize: 11,
          fontFamily: 'segoeUI',
        ),
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontFamily: 'segoeUI',
        ),
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xff5E5E5E),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
