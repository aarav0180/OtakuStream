import 'package:flutter/material.dart';
import 'package:otaku_stream/Screens/explorepage.dart';
import 'package:otaku_stream/Screens/homepage.dart';
import 'package:otaku_stream/Screens/profile_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.07; // Adjust icon size based on screen width
    final padding = screenWidth * 0.02; // Adjust padding

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Semi-transparent background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.person,
            label: 'Profile',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
            iconSize: iconSize,
          ),
          _buildNavItem(
            icon: Icons.play_circle_fill,
            label: 'Watch',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
            isCenter: true,
            iconSize: iconSize * 1.5,
          ),
          _buildNavItem(
            icon: Icons.explore_outlined,
            label: 'Explore',
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
            iconSize: iconSize,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required double iconSize,
    bool isCenter = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCenter ? iconSize / 3.4 : iconSize / 3.3,
          vertical: isCenter ? iconSize / 5.2 : iconSize / 5.2,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFFFA726),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.orange : Colors.white,
              size: iconSize,
            ),
            SizedBox(width: iconSize / 6),
            Text(
              label,
              style: TextStyle(
                fontSize: iconSize / 2.9,
                color: isSelected ? Colors.orange : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const ProfilePage(),//const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
    const AnimeHomeScreen(),
    const ExplorePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _pages[_currentIndex],

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }
}

