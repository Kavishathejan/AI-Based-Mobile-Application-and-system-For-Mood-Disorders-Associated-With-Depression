import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screens/Step5Screen.dart';
import 'screens/Afternoonrouting.dart';
import 'screens/ChatScreen.dart';
import 'screens/EditProfileScreen.dart';
import 'screens/Home.dart';
import 'screens/LogoutScreen.dart';
import 'screens/Morningrouting.dart';
import 'screens/Notificationscreen.dart';
import 'screens/ParentScreen.dart';
import 'screens/ProfileScreen.dart';
import 'screens/SettingScreen.dart';
import 'screens/SplashScreen.dart';
import 'screens/DescriptionScreen.dart';
import 'screens/SigninScreen.dart';
import 'screens/SignUpScreen.dart';
import 'screens/CreateAccountScreen.dart';
import 'screens/GadsurveyScreen.dart';
import 'screens/Step10Screen.dart';
import 'screens/Step1Screen.dart';
import 'screens/Step2Screen.dart';
import 'screens/Step3Screen.dart';
import 'screens/Step4Screen.dart';
import 'screens/Step7Screen.dart';
import 'screens/Step8Screen.dart';
import 'screens/Step9Screen.dart';
import 'screens/Step6Screen.dart';

/// ✅ Background Message Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📩 Handling background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ No need to initialize WebViewPlatform.instance manually

  // ✅ Firebase Initialization
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCTnzl95OFW9w0DrG9ulwYPz2tbL-uuq64",
      authDomain: "joynest-app.firebaseapp.com",
      projectId: "joynest-app",
      storageBucket: "joynest-app.appspot.com",
      messagingSenderId: "891255618785",
      appId: "1:891255618785:android:42a89d3bf2f45cd8c64ba0",
      databaseURL:
          "https://joynest-app-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _requestNotificationPermissions();
    _setupForegroundNotificationListener();
  }

  /// ✅ Request notification permissions
  void _requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Notifications Allowed");
    } else {
      print("❌ Notifications Denied");
    }
  }

  /// ✅ Listen for foreground messages
  void _setupForegroundNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔔 New foreground notification: ${message.notification?.title}");
      print("📜 Body: ${message.notification?.body}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joynest',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/SplashScreen',
      routes: _routes(),
    );
  }

  /// 🔹 Organized Routes
  Map<String, Widget Function(BuildContext)> _routes() {
    return {
      '/SplashScreen': (context) => SplashScreen(),
      '/DescriptionScreen': (context) => DescriptionScreen(),
      '/SignInScreen': (context) => SignInScreen(),
      '/SignUpScreen': (context) => SignUpScreen(),
      '/CreateAccountScreen': (context) => CreateAccountScreen(),
      '/GadsurveyScreen': (context) => GadsurveyScreen(),
      '/Step1Screen': (context) => Step1Screen(),
      '/Step2Screen': (context) => Step2Screen(),
      '/Step3Screen': (context) => Step3screen(),
      '/Step4Screen': (context) => Step4Screen(),
      '/Step5Screen': (context) => Step5Screen(),
      '/Step6Screen': (context) => Step6Screen(),
      '/Step7Screen': (context) => Step7Screen(),
      '/Step8Screen': (context) => Step8Screen(),
      '/Step9Screen': (context) => Step9Screen(),
      '/Step10Screen': (context) => Step10Screen(),
      '/ParentScreen': (context) => ParentScreen(),
      '/Morningrouting': (context) => Morningrouting(),
      '/Afternoonrouting': (context) => AfternoonRouting(),
      '/LogoutScreen': (context) => LogoutScreen(),
      '/ProfileScreen': (context) => ProfileScreen(),
      '/Notificationscreen': (context) => Notificationscreen(),
      '/EditProfileScreen': (context) => EditProfileScreen(),
      '/SettingsScreen': (context) => SettingsScreen(),
      '/ChatScreen': (context) => ChatScreen(),
      '/HomeScreen': (context) => HomeScreen(),
      '/': (context) => HomeScreen(),
    };
  }
}
