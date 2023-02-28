import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      print(
          "------------------------------------------------------------------\n\n\n\n\n");
      print("user $user");
      print(
          "------------------------------------------------------------------\n\n\n\n\n");
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // ProfileWidget(
          //   imagePath: user.,
          //   onClicked: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => EditProfilePage()),
          //     );
          //   },
          // ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.displayName ?? "name not found",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? "not found",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.email ?? "email not found",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
