import 'package:bgi_test_app/views/first_screen.dart';
import 'package:bgi_test_app/views/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../helper/authenticate.dart';
import '../helper/constants.dart';
import '../views/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    // initializeFirebaseApp();
    getLoggedInState();
    super.initState();
  }

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BGI Test Invite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: controller,
      home: FirstScreen(),
    );
  }
}
