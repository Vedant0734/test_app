import 'package:bgi_test_app/views/auth_screen.dart';
import 'package:bgi_test_app/views/settings.dart';
import 'package:flutter/material.dart';

const String firstPage = '';
const String settingspage = 'settings.dart';
const String profile = '';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case firstPage:
      return MaterialPageRoute(builder: (context) => AuthenticationScreen());
    case settingspage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
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
