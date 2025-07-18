import 'package:flutter/material.dart';
import 'Notificationscreen.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false; // Toggle state for Dark Mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Gray Bar at the Top
            Container(
              height: 60,
              color: const Color.fromARGB(205, 216, 221, 217),
            ),

            // App Bar with Back Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Settings Options
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  buildCategoryTitle("Interface"),
                  buildSettingsTile(
                    title: "Dark mode",
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                      },
                    ),
                  ),
                  buildSettingsTile(
                    title: "Notifications",
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notificationscreen()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  buildCategoryTitle("Language & region"),
                  buildSettingsTile(
                    title: "English (US)",
                    onTap: () {
                      // Handle language selection
                    },
                  ),
                  SizedBox(height: 20),
                  buildCategoryTitle("Support"),
                  buildSettingsTile(
                    title: "About Us",
                    onTap: () {
                      // Handle About Us page
                    },
                  ),
                  buildSettingsTile(
                    title: "Delete Account",
                    onTap: () {
                      // Handle account deletion
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for section titles
  Widget buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Widget for individual settings tiles
  Widget buildSettingsTile(
      {required String title, Widget? trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
