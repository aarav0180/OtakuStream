import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define a function to calculate font size based on screen width
    double responsiveFontSize(double fontSize) {
      return screenWidth * fontSize;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE08B27), Colors.black], // Orange to Black gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // Responsive horizontal padding
              vertical: screenHeight * 0.03, // Responsive vertical padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar-like section
                SizedBox(height: screenHeight * 0.05),
                Center(
                  child: Text(
                    "About OtakuStream",
                    style: TextStyle(
                      fontSize: responsiveFontSize(0.07), // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Spacing between sections

                // App Logo or Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/logo-bg.png",
                      width: screenWidth * 0.7, // Responsive width
                      height: screenWidth * 0.7, // Responsive height
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01), // Spacing between sections

                // About Text Header
                Center(
                  child: Text(
                    "Discover OtakuStream",
                    style: TextStyle(
                      fontSize: responsiveFontSize(0.06), // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // Spacing

                // Description Text
                Text(
                  "OtakuStream is your one-stop app for all things anime. "
                      "From detailed information about your favorite anime to free episodes for you to enjoy, "
                      "we bring the anime world closer to you. Immerse yourself in the vibrant stories, characters, "
                      "and worlds that anime has to offer—all in one sleek and easy-to-use app.",
                  style: TextStyle(
                    fontSize: responsiveFontSize(0.040), // Responsive font size
                    color: Colors.white70, // Subtle white text
                    height: 1.5, // Line height for readability
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing

                // Highlight Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA726), // Orange background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Enjoy free anime information and episodes, anytime, anywhere!",
                    style: TextStyle(
                      fontSize: responsiveFontSize(0.046), // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Contrast with orange
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.09), // Spacing

                // Footer Text
                Center(
                  child: Text(
                    "Made with ❤️ for anime enthusiasts!",
                    style: TextStyle(
                      fontSize: responsiveFontSize(0.035), // Responsive font size
                      color: Colors.white54, // Subtle footer text
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
