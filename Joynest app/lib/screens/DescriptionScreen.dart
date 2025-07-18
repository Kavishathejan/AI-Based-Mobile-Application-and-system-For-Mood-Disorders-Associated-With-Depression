import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDD8DD),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  // Description Text
                  Positioned(
                    left: 51,
                    top: 430,
                    child: SizedBox(
                      width: 315,
                      child: Text(
                        '"Welcome to our app, designed with care for individuals coping with mental health challenges. Here, you\'ll find a supportive space crafted to aid in your journey towards well-being. Whether you\'re seeking guidance, relaxation, or simply a listening ear, our app is here to accompany you every step of the way. Together, let\'s embark on a path of healing and empowerment. Tap \"OK\" to begin your exploration."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  // Top Logo
                  Positioned(
                    left: -20,
                    top: -100,
                    child: Container(
                      width: 262,
                      height: 320,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/11.png"), // Replace with your logo asset
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // "Ok" Text Button
                  Positioned(
                    left: 50, // Center the "Ok" button
                    top: 730,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/SignInScreen'); // Navigate to SignInScreen
                      },
                      child: Text(
                        'Ok',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF7BA7D7),
                          fontSize: 20,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  // Next Button
                  Positioned(
                    right: 20,
                    top: 700,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/LoginScreen'); // Navigate to LoginScreen
                      },
                      child: Container(
                        width: 81,
                        height: 92,
                        alignment: Alignment.center, // Center the icon
                        child: Icon(
                          Icons.arrow_forward, // Google Material Icon for "Next"
                          size: 40, // Icon size
                          color: Color(0xff7BA7D7), // Icon color
                        ),
                      ),
                    ),
                  ),
                  // Center Image
                  Positioned(
                    left: 48,
                    top: 150,
                    child: Container(
                      width: 315,
                      height: 272,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/2.png"), // Replace with your center image asset
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
