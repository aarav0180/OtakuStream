import 'package:flutter/material.dart';
import 'package:otaku_stream/Screens/HomePage.dart';
import 'package:otaku_stream/Screens/about_page.dart';

class AnimeAppMenu extends StatefulWidget {

  const AnimeAppMenu({super.key});

  @override
  State<AnimeAppMenu> createState() => _AnimeAppMenuState();
}

class _AnimeAppMenuState extends State<AnimeAppMenu> {
  // final List<MenuItem> menuItems = [
  //   MenuItem(
  //     icon: Icons.home,
  //     title: "Home",
  //     onTap: () {
  //       // Navigate to Home
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeHomeScreen()));
  //
  //       Navigator.push(context, MaterialPageRoute(builder: (_) => AnimeHomeScreen()));
  //     },
  //   ),
  //   MenuItem(
  //     icon: Icons.movie,
  //     title: "Movies",
  //     onTap: () {
  //       // Navigate to Movies
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const MoviesPage()));
  //     },
  //   ),
  //   MenuItem(
  //     icon: Icons.tv,
  //     title: "TV Shows",
  //     onTap: () {
  //       // Navigate to TV Shows
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const TVShowsPage()));
  //     },
  //   ),
  //   MenuItem(
  //     icon: Icons.favorite,
  //     title: "Favorites",
  //     onTap: () {
  //       // Navigate to Favorites
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesPage()));
  //     },
  //   ),
  //   MenuItem(
  //     icon: Icons.settings,
  //     title: "Settings",
  //     onTap: () {
  //       // Navigate to Settings
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  //     },
  //   ),
  //   MenuItem(
  //     icon: Icons.info,
  //     title: "About",
  //     onTap: () {
  //       // Navigate to About
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
  //     },
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    // Get screen size to make the menu responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define menu items inside the build method to access `context`
    final List<MenuItem> menuItems = [
      MenuItem(
        icon: Icons.home,
        title: "Home",
        onTap: () {

        },
      ),
      MenuItem(
        icon: Icons.movie,
        title: "Movies",
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const MoviesPage()),
          // );
        },
      ),
      MenuItem(
        icon: Icons.tv,
        title: "TV Shows",
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const TVShowsPage()),
          // );
        },
      ),
      MenuItem(
        icon: Icons.favorite,
        title: "Favorites",
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const FavoritesPage()),
          // );
        },
      ),
      MenuItem(
        icon: Icons.settings,
        title: "Settings",
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SettingsPage()),
          // );
        },
      ),
      MenuItem(
        icon: Icons.info,
        title: "About",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
      ),
    ];

    return Drawer(
      backgroundColor: Colors.black, // Dark theme background
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFA726), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                // Anime Icon or Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/logo-bg.png",
                    width: screenWidth * 0.28, // Responsive width
                    height: screenWidth * 0.28, // Responsive height
                    fit: BoxFit.cover,
                  ),
                ),
                // Anime App Title
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OtakuStream",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Vibe with your favorites!",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFFA726),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: const Color(0xFFFFA726),
                      size: MediaQuery.of(context).size.width * 0.06, // Responsive icon size
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the menu
                      item.onTap?.call(); // Call the item's onTap function
                    },
                  );
                },
              ),
            ),
          ),

          // Footer (optional)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: screenWidth * 0.05, // Responsive horizontal padding
            ),
            child: const Text(
              "© 2024 OtakuStream. All Rights Reserved.",
              style: TextStyle(color: Color(0xFFFFA726), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenHeight * 0.09),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String title;
  final Function()? onTap; // Optional callback function

  MenuItem({required this.icon, required this.title, this.onTap});
}

