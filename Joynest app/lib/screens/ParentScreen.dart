import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  late WebSocketChannel channel;
  List<dynamic> logs = [];
  String? notificationMessage;
  String? notificationTime;
  String? fcmToken;
  String? patientMood; // Store the patient's latest mood

  @override
  void initState() {
    super.initState();
    connectWebSocket();
    getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        setState(() {
          notificationMessage = message.notification!.body;
          notificationTime =
              DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now().toLocal());
        });
      }
    });
  }

  String formatTime(String isoTime) {
    try {
      DateTime parsedTime = DateTime.parse(isoTime).toLocal();
      return DateFormat('yyyy-MM-dd hh:mm a').format(parsedTime);
    } catch (e) {
      return "Invalid Time";
    }
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3001'));
    channel.stream.listen((data) {
      var decodedData = json.decode(data);
      print('Received data: $decodedData'); // Debugging line to see the data

      setState(() {
        if (decodedData['type'] == 'logs') {
          logs = decodedData['data'];
        } else if (decodedData['type'] == 'mood') {
          patientMood = decodedData['data']['mood']; // Update patient mood
        }
      });
    });
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
    setState(() {
      fcmToken = token;
    });
    sendTokenToBackend(token);
  }

  void sendTokenToBackend(String? token) async {
    if (token == null) return;
    final url = Uri.parse('http://localhost:3001/registerToken');
    final response = await http.post(url, body: {'token': token});

    if (response.statusCode == 200) {
      print("✅ Token sent to backend successfully!");
    } else {
      print("❌ Failed to send token to backend");
    }
  }

  void dismissNotification() {
    setState(() {
      notificationMessage = null;
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  // Get mood image based on the patient's mood
  String getMoodImage(String? mood) {
    switch (mood?.toLowerCase()) {
      case 'sad':
        return 'lib/assets/sad.png';
      case 'normal':
        return 'lib/assets/normal.png';
      case 'angry':
        return 'lib/assets/angry.png';
      case 'lovely':
        return 'lib/assets/lovely.png';
      case 'depressed':
        return 'lib/assets/depressed.png';
      default:
        return 'lib/assets/load.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notificationMessage != null)
                Dismissible(
                  key: Key(notificationMessage!),
                  onDismissed: (direction) => dismissNotification(),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.redAccent,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "🚨 Your child needs support!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "🔍 Searched: $notificationMessage\n⏰ Time: $notificationTime",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                height: 78,
                color: Color(0xFFCCD8DD),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: Text(
                  'Welcome Parent!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Patient's Current Mood in Ellipse Container
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        getMoodImage(patientMood),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Patient's Mood: ${patientMood ?? 'Unknown'}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '🔍 Search Logs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              logs.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: logs.reversed.map((log) {
                          return Card(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text("🔍 ${log["query"]}"),
                              subtitle: Text("⏰ ${formatTime(log["time"])}"),
                              trailing: Text("🛑 ${log["keyword"]}"),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
