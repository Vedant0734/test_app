import 'package:bgi_test_app/models/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 50),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.phone,
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
              user.phone,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
