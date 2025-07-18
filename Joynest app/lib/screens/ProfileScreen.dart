import 'package:flutter/material.dart';
import 'EditProfileScreen.dart';
import 'FunnyScreen.dart';
import 'Home.dart';
import 'LogoutScreen.dart';
import 'SettingScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Profile tab index
  final PageController _pageController = PageController();

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller and animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation loop
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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
            // Profile Section
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("lib/assets/Male.png"),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Middle Menu Items
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    buildMenuItem(
                      title: "Edit Profile",
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()),
                        );
                      },
                    ),
                    buildMenuItem(
                      title: "Settings",
                      icon: Icons.settings,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()),
                        );
                      },
                    ),
                    buildMenuItem(
                      title: "Privacy Policy",
                      icon: Icons.privacy_tip,
                      onTap: () {
                        // Handle navigation for Privacy Policy
                      },
                    ),
                    buildMenuItem(
                      title: "Logout",
                      icon: Icons.logout,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogoutScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 123, 167, 215),
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), // Left-side upper rounded border
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                size: _currentIndex == 1 ? 40 : 30,
                color: _currentIndex == 0
                    ? Colors.white
                    : const Color.fromARGB(0, 0, 0, 0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                setState(() {
                  _currentIndex = 0;
                  _pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.spa,
                size: _currentIndex == 1 ? 40 : 30,
                color: _currentIndex == 0
                    ? Colors.white
                    : const Color.fromARGB(0, 0, 0, 0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FunnyScreen()),
                );
                setState(() {
                  _currentIndex = 1;
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.message,
                size: _currentIndex == 2 ? 0 : 0,
                color: _currentIndex == 2 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FunnyScreen()),
                );
                setState(() {
                  _currentIndex = 2;
                  _pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          ],
        ),
      ),

      // Floating "Chat with Me" Icon with Animation
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 100, // Increased size of the FAB
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 10, // Blur radius
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, '/ChatScreen'); // Navigate to LoginScreen
            },
            backgroundColor: Colors.transparent, // Remove background
            elevation: 0, // Remove shadow
            child: Image.asset(
              "lib/assets/chat.png",
              width: 150, // Increased size of the chat icon
              height: 150,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget buildMenuItem({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.black),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
