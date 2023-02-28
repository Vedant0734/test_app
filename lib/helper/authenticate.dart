// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import '../views/signin.dart';
// import '../views/signup.dart';

// class Authenticate extends StatefulWidget {
//   const Authenticate({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AuthenticateState createState() => _AuthenticateState();
// }

// class _AuthenticateState extends State<Authenticate> {
//   bool showSignIn = true;
//   @override
//   void initState() {
//     Firebase.initializeApp();
//     super.initState();
//   }

//   void toggleView() {
//     setState(() {
//       showSignIn = !showSignIn;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showSignIn) {
//       return SignIn();
//     } else {
//       return SignUp();
//     }
//   }
// }
