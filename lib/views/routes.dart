import 'package:bgi_test_app/views/first_screen.dart';
import 'package:bgi_test_app/views/settings.dart';
import 'package:bgi_test_app/views/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String firstPage = '';
const String settingspage = 'settings.dart';
const String backup = '';
const String profile = '';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case firstPage:
      return MaterialPageRoute(builder: (context) => FirstScreen());
    case settingspage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    case backup:
      return MaterialPageRoute(
        builder: (context) => SettingsPage(),
      );
    // case profile:
    //   return MaterialPageRoute(
    //     builder: (context) => ProfilePage(),
    //   );
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text("Invalid Page"),
                ),
              ));
  }
}
