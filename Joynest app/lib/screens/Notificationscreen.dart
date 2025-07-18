import 'package:flutter/material.dart';

class Notificationscreen extends StatefulWidget {
  @override
  _NotificationscreenState createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  bool isShow = false;
  bool isSound = false;
  bool isReact = false;
  bool ispreview = false;

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
                    "Notifications",
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
                  buildCategoryTitle("Notifications"),
                  buildSettingsTile(
                    title: "Show notification",
                    trailing: Switch(
                      value: isShow,
                      onChanged: (value) {
                        setState(() {
                          isShow = value;
                        });
                      },
                    ),
                  ),
                  buildSettingsTile(
                    title: "Sound",
                    trailing: Switch(
                      value: isSound,
                      onChanged: (value) {
                        setState(() {
                          isSound = value;
                        });
                      },
                    ),
                  ),
                  buildSettingsTile(
                    title: "Reaction notification",
                    trailing: Switch(
                      value: isReact,
                      onChanged: (value) {
                        setState(() {
                          isReact = value;
                        });
                      },
                    ),
                  ),
                  buildSettingsTile(
                    title: "Show Preview",
                    trailing: Switch(
                      value: ispreview,
                      onChanged: (value) {
                        setState(() {
                          ispreview = value;
                        });
                      },
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
