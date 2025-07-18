import 'package:flutter/material.dart';

//import 'AnonymouseScreen.dart';
import 'Home.dart';


class GadsurveyresultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCDD8DD),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Survey Results",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Image.asset(
              'lib/assets/results.png', // Ensure this exists in assets
              height: 345,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    "Your depression level is Severe, here are some recommendations:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.chat_bubble_outline, color: Colors.blue),
                    title: Text("Chat with our app to relax your mind"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.schedule, color: Colors.blue),
                    title: Text("Check your personalized routine to manage your depression level"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),) ;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF88BDF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
              ),
              child: const Text(
                "Continue to Home",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
