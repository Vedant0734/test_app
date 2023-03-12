import 'package:bgi_test_app/business_logic/theme_cubit/cubit/theme_cubit.dart';
import 'package:bgi_test_app/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'change_password.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 4, 8, 250));

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return SwitchListTile(
                    value: state.theme.currentTheme == CustomTheme.darkTheme, 
                    title: const Text("Theme"),
                    activeColor: Theme.of(context).primaryColor,
                    subtitle: Text(state.theme.currentTheme == CustomTheme.darkTheme ? "Dark" : 
                    "Light"),
                    onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
                  );
                },
              ),              
              const Divider(),              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Security", style: headingStyle),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Change Password"),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen(),)),
              ),
              const ListTile(
                leading: Icon(Icons.file_open_outlined),
                title: Text("Terms of Service"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.file_copy_outlined),
                title: Text("Open Source and Licences"),
              ),
            ],
          ),
        ),
      ),
    );

    //     : CupertinoApp(
    //     debugShowCheckedModeBanner: false,
    //     home: CupertinoPageScaffold(
    //       navigationBar: const CupertinoNavigationBar(
    //         backgroundColor: CupertinoColors.destructiveRed,
    //         middle: Text("Settings UI"),
    //       ),
    //       child: Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         color: CupertinoColors.extraLightBackgroundGray,
    //         child: Column(
    //           children: [
    //             //Common
    //             const SizedBox(height: 14),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const SizedBox(width: 12),
    //                 Text(
    //                   "Common",
    //                   style: headingStyleIOS,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 8),
    //             Container(
    //               width: double.infinity,
    //               color: CupertinoColors.white,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(width: 12),
    //                         const Icon(
    //                           Icons.language,
    //                           color: Colors.grey,
    //                         ),
    //                         const SizedBox(width: 12),
    //                         const Text("Language"),
    //                         const Spacer(),
    //                         Text(
    //                           "English",
    //                           style: descStyleIOS,
    //                         ),
    //                         const SizedBox(width: 5),
    //                         const Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         const SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     width: double.infinity,
    //                     height: 38,
    //                     alignment: Alignment.center,
    //                     child: Row(
    //                       children: [
    //                         const SizedBox(width: 12),
    //                         const Icon(
    //                           Icons.cloud,
    //                           color: Colors.grey,
    //                         ),
    //                         const SizedBox(width: 12),
    //                         const Text("Environment"),
    //                         const Spacer(),
    //                         Text(
    //                           "Production",
    //                           style: descStyleIOS,
    //                         ),
    //                         const SizedBox(width: 5),
    //                         const Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         const SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             //Account
    //             const SizedBox(height: 14),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const SizedBox(width: 12),
    //                 Text(
    //                   "Account",
    //                   style: headingStyleIOS,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 8),
    //             Container(
    //               width: double.infinity,
    //               color: CupertinoColors.white,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         SizedBox(width: 12),
    //                         Icon(
    //                           Icons.phone,
    //                           color: Colors.grey,
    //                         ),
    //                         SizedBox(width: 12),
    //                         Text("Phone Number"),
    //                         Spacer(),
    //                         Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         SizedBox(width: 12),
    //                         Icon(
    //                           Icons.mail,
    //                           color: Colors.grey,
    //                         ),
    //                         SizedBox(width: 12),
    //                         Text("Email"),
    //                         Spacer(),
    //                         Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         SizedBox(width: 12),
    //                         Icon(
    //                           Icons.exit_to_app,
    //                           color: Colors.grey,
    //                         ),
    //                         SizedBox(width: 12),
    //                         Text("Sign Out"),
    //                         Spacer(),
    //                         Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             //Security
    //             const SizedBox(height: 14),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const SizedBox(width: 12),
    //                 Text(
    //                   "Security",
    //                   style: headingStyleIOS,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 8),
    //             Container(
    //               width: double.infinity,
    //               color: CupertinoColors.white,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(width: 12),
    //                         const Icon(
    //                           Icons.phonelink_lock_outlined,
    //                           color: Colors.grey,
    //                         ),
    //                         const SizedBox(width: 12),
    //                         const Text("Lock app in Background"),
    //                         const Spacer(),
    //                         CupertinoSwitch(
    //                             value: lockAppSwitchVal,
    //                             activeColor: CupertinoColors.destructiveRed,
    //                             onChanged: (val) {
    //                               setState(() {
    //                                 lockAppSwitchVal = val;
    //                               });
    //                             }),
    //                         const SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(width: 12),
    //                         const Icon(
    //                           Icons.fingerprint,
    //                           color: Colors.grey,
    //                         ),
    //                         const SizedBox(width: 12),
    //                         const Text("Use Fingerprint"),
    //                         const Spacer(),
    //                         CupertinoSwitch(
    //                           value: fingerprintSwitchVal,
    //                           onChanged: (val) {
    //                             setState(() {
    //                               fingerprintSwitchVal = val;
    //                             });
    //                           },
    //                         ),
    //                         const SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         const SizedBox(width: 12),
    //                         const Icon(
    //                           Icons.lock,
    //                           color: Colors.grey,
    //                         ),
    //                         const SizedBox(width: 12),
    //                         const Text("Change Password"),
    //                         const Spacer(),
    //                         CupertinoSwitch(
    //                           value: changePassSwitchVal,
    //                           activeColor: CupertinoColors.destructiveRed,
    //                           onChanged: (val) {
    //                             setState(() {
    //                               changePassSwitchVal = val;
    //                             });
    //                           },
    //                         ),
    //                         const SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             //Misc
    //             const SizedBox(height: 14),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const SizedBox(width: 12),
    //                 Text(
    //                   "Misc",
    //                   style: headingStyleIOS,
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 8),
    //             Container(
    //               width: double.infinity,
    //               color: CupertinoColors.white,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         SizedBox(width: 12),
    //                         Icon(
    //                           Icons.file_open_sharp,
    //                           color: Colors.grey,
    //                         ),
    //                         SizedBox(width: 12),
    //                         Text("Terms of Service"),
    //                         Spacer(),
    //                         Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Container(
    //                     alignment: Alignment.center,
    //                     width: double.infinity,
    //                     height: 38,
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: const [
    //                         SizedBox(width: 12),
    //                         Icon(
    //                           Icons.file_copy_sharp,
    //                           color: Colors.grey,
    //                         ),
    //                         SizedBox(width: 12),
    //                         Text("Open Source Licenses"),
    //                         Spacer(),
    //                         Icon(
    //                           CupertinoIcons.right_chevron,
    //                           color: CupertinoColors.inactiveGray,
    //                         ),
    //                         SizedBox(width: 8),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }
}
