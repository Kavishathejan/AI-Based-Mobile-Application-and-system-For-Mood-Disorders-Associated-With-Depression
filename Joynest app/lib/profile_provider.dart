import 'package:flutter/material.dart';
import 'user_profile.dart'; // Import the UserProfile model

class ProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(name: "Shashi", email: "");

  UserProfile get userProfile => _userProfile;

  void updateProfile(String name, String email) {
    _userProfile = UserProfile(name: name, email: email);
    notifyListeners();
  }
}