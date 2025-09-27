import 'package:flutter/material.dart';
import 'package:flutter_assignment/screen/home_screen.dart';
import 'package:flutter_assignment/screen/order_screen.dart';
import 'package:flutter_assignment/screen/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavLayout extends StatefulWidget {
  const BottomNavLayout({super.key});

  @override
  State<BottomNavLayout> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  int _selectedIndex = 0;

  // Screens you want to keep fixed
  final List<Widget> _screens = [
    HomeScreen(),        // Replace with your actual screen widgets
    OrdersScreen(),
    ProfileScreen(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens ,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? Colors.blue : Color(0xFF617D8A),
                  BlendMode.srcIn,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/order.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.blue : Color(0xFF617D8A),
                  BlendMode.srcIn,
                ),
              ),
              label: "Order",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.blue : Color(0xFF617D8A),
                  BlendMode.srcIn,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
