import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'CreateAccountScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isChecked = false;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate() || !isChecked) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await _database.child("users").child(user.uid).set({
          "fullName": _fullNameController.text.trim(),
          "email": _emailController.text.trim(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-Up Successful!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateAccountScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred.";
      if (e.code == 'email-already-in-use') {
        message = "Email is already registered.";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak.";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDD8DD),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Full Name", Icons.person, _fullNameController),
              SizedBox(height: 15),
              _buildTextField("Email", Icons.email, _emailController),
              SizedBox(height: 15),
              _buildTextField("Password", Icons.lock, _passwordController,
                  isPassword: true),
              SizedBox(height: 15),
              _buildTextField(
                  "Confirm Password", Icons.lock, _confirmPasswordController,
                  isPassword: true),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text("I agree to "),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "$label cannot be empty";
        if (label == "Email" &&
            !RegExp(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+')
                .hasMatch(value)) {
          return "Enter a valid email";
        }
        if ((label == "Password" || label == "Confirm Password") &&
            value.length < 6) {
          return "Password must be at least 6 characters";
        }
        if (label == "Confirm Password" && value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }
}
