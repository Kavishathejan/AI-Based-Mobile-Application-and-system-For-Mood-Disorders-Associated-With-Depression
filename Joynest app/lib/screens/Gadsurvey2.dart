import 'package:flutter/material.dart';

import 'SurveyresultScreen.dart';

// Import Step1Screen or create it.
// Ensure the Step1Screen file exists or create one.

class Gadsurvey2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDD8DD),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Let’s start GAD survey",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            // Ensure the image path exists in assets and is declared in pubspec.yaml.
            Image.asset(
              'lib/assets/3.png',
              height: 345,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              "'You have successfully completed the questionnaire'",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GadsurveyresultScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF88BDF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
              ),
              child: Text(
                "View Results",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
            
          ],
        ),
      ),
    );
  }
}
