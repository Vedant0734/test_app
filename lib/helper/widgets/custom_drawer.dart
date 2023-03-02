import 'package:flutter/material.dart';
import 'package:bgi_test_app/routes.dart' as route;
import '../../models/user.dart';
import '../../views/profile_page.dart';

class ReusableDrawer extends StatelessWidget {
  const ReusableDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName:
                  Text(user.userName ),
              accountEmail: Text(user.phone )),

          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text('Help'),
          // ),
          ListTile(
            leading: Icon(
              Icons.person,
            ),
            title: const Text('profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: user),
                  ));
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.logout,
          //   ),
          //   title: const Text('Settings 1'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SettingsPage(),
          //         ));
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: const Text('Signout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                route.firstPage,
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(
                context,
                route.settingspage,
              );
            },
          ),
        ],
      ),
    );
  }
}