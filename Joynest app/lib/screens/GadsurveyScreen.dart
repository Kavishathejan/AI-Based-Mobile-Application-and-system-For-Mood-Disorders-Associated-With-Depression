import 'package:flutter/material.dart';
import 'step1screen.dart'; // Ensure the Step1Screen file exists or create one.

class GadsurveyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDD8DD),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Let’s start GAD survey",
              style: TextStyle(
                fontSize: screenWidth < 350 ? 24 : 28, // Adjust font size for smaller screens
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.06),
            Image.asset(
              'lib/assets/3.png',
              height: screenHeight * 0.4, // Image height adjusts based on screen height
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                "Start the GAD survey to assess your mental health—your responses and sensitive information will remain secure and confidential.",
                style: TextStyle(
                  fontSize: screenWidth < 350 ? 14 : 16, // Adjust font size for smaller screens
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Step1Screen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF88BDF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25, vertical: 16),
              ),
              child: Text(
                "Start",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Text(
                "By clicking ‘Start’ you agree to our Terms of Service & Privacy Policy",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
