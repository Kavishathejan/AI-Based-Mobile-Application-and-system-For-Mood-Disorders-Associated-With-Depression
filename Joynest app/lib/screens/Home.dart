import 'dart:async'; // Import for Timer
import 'dart:convert'; // Import for JSON encoding
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart'; // Import for WebSocket
import 'Afternoonrouting.dart';
import 'FunnyScreen.dart';
import 'Morningrouting.dart';
import 'NightRouting.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Track the selected tab
  final PageController _pageController =
      PageController(); // For page transitions

  // Animation controller for the floating action button
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // For rotating inspiration cards
  late Timer _timer;
  int _currentCardIndex = 0;
  final List<Map<String, dynamic>> _inspirationCards = [
    {
      "text":
          "You are not your depression.\nYou are capable, resilient, and in control of your journey.",
      "image": "lib/assets/girl.png",
      "color": Colors.blue[50], // Light blue
    },
    {
      "text":
          "Every small step you take is a victory.\nCelebrate your progress!",
      "image": "lib/assets/img.png",
      "color": const Color.fromARGB(255, 231, 196, 240), // Light green
    },
    {
      "text": "You are stronger than you think.\nKeep moving forward!",
      "image": "lib/assets/home.png",
      "color": const Color.fromARGB(255, 245, 202, 202), // Light orange
    },
  ];

  late WebSocketChannel channel;

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

    // Start the timer for rotating inspiration cards
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentCardIndex = (_currentCardIndex + 1) % _inspirationCards.length;
      });
    });

    connectWebSocket();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3001'));
  }

  void sendMoodUpdate(String mood) {
    final moodData = {
      'type': 'mood',
      'data': {'mood': mood, 'time': DateTime.now().toIso8601String()}
    };
    channel.sink.add(json.encode(moodData));
    print("Sent mood update: $mood");
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    channel.sink.close(); // Close the WebSocket connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Gray Bar
            Container(
              height: 50,
              color: Color(0xFFCDD8DD),
            ),

            // Welcome Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Shashi!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Here's your daily update",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Inspiration Card (Rotating)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey<int>(_currentCardIndex),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _inspirationCards[_currentCardIndex]
                        ["color"], // Dynamic color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _inspirationCards[_currentCardIndex]["text"],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Image.asset(
                        _inspirationCards[_currentCardIndex]["image"],
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Mood Selection Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "How are you today?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  moodButton("lib/assets/sad.png", "Sad"),
                  moodButton("lib/assets/normal.png", "Normal"),
                  moodButton("lib/assets/lovely.png", "Lovely"),
                  moodButton("lib/assets/depressed.png", "Depressed"),
                  moodButton("lib/assets/angry.png", "Angry"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Personalized Routines Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Personalized Routines",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  routineCard(context, "Morning Routine"),
                  routineCard(context, "Afternoon Routine"),
                  routineCard(context, "Night Routine"),
                ],
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
              topLeft: Radius.circular(40),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                size: _currentIndex == 0 ? 40 : 30,
                color: _currentIndex == 0
                    ? const Color.fromARGB(255, 8, 63, 94)
                    : Colors.white,
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
                color: _currentIndex == 1
                    ? const Color.fromARGB(255, 8, 63, 94)
                    : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FunnyScreen()),
                  );
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
                color: _currentIndex == 2
                    ? const Color.fromARGB(255, 8, 63, 94)
                    : Colors.white,
              ),
              onPressed: () {
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
          width: 130, // Increased size of the FAB
          height: 130,
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

  // Mood Button Widget
  Widget moodButton(String imagePath, String mood) {
    return GestureDetector(
      onTap: () {
        sendMoodUpdate(mood);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Image.asset(imagePath, width: 40, height: 40),
          ),
          const SizedBox(height: 5),
          Text(mood,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget routineCard(BuildContext context, String title) {
    // Determine the image based on the title
    String imagePath;
    if (title == "Morning Routine") {
      imagePath =
          "lib/assets/morning.png"; // Replace with your morning image path
    } else if (title == "Afternoon Routine") {
      imagePath =
          "lib/assets/afternoon.png"; // Replace with your afternoon image path
    } else if (title == "Night Routine") {
      imagePath = "lib/assets/night.png"; // Replace with your night image path
    } else {
      imagePath = "lib/assets/default.png"; // Default image if needed
    }

    return Container(
      margin: const EdgeInsets.only(
          bottom: 10), // Increased margin for larger container
      decoration: BoxDecoration(
        color: Colors.blue, // Blue margin around the card
        borderRadius:
            BorderRadius.circular(15), // Slightly larger border radius
      ),
      child: Card(
        color: Colors.white, // White background for the card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
              const EdgeInsets.all(5), // Increased padding for larger container
          child: Row(
            children: [
              // Left side: Image
              Image.asset(imagePath,
                  width: 150, height: 150), // Increased image size
              const SizedBox(
                  width: 10), // Increased spacing between image and text
              // Right side: Text and Button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top: Text
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20), // Increased font size
                    ),
                    const SizedBox(
                        height:
                            15), // Increased spacing between text and button
                    // Bottom: Start Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to respective routine page
                        if (title == "Morning Routine") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Morningrouting()),
                          );
                        } else if (title == "Afternoon Routine") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AfternoonRouting()),
                          );
                        } else if (title == "Night Routine") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NightRouting()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF083F5E), // Blue button color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15), // Increased button padding
                      ),
                      child: const Text("Start",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16)), // Increased font size
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
