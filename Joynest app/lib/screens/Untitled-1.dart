import 'package:flutter/material.dart';

class Signinscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the SignUp screen
    void navigateToSignUp() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Sign-In Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Email Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xFFCCD8DD),
                    ),
                  ),
                ),
              ),
            ),

            // Password Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xFFCCD8DD),
                    ),
                  ),
                ),
              ),
            ),

            // Forgot Password and Sign In Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        print("Forgot Password clicked!");
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF747171),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      print("Sign In button clicked!");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF7BA7D7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sign Up Link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                        color: Color(0xFF7BA7D7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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

// Placeholder for SignUpScreen
class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Text("Sign Up Page"),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signinscreen(),
  ));
}
