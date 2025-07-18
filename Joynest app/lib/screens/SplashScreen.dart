import 'package:flutter/material.dart';
import 'DescriptionScreen.dart'; // Import your DescriptionScreen

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the DescriptionScreen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DescriptionScreen()),
      );
    });

    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFD9E6F2), // Light blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive logo image
            Image.asset(
              'lib/assets/11.png',
              height: screenHeight * 0.6, // 60% of screen height
              width: screenWidth * 0.9, // 90% of screen width
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}