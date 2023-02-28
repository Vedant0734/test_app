// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';

import '../models/user.dart';
// import '../models/user.dart';

class AuthService {
  final String serverAddress = 'http://192.168.43.149:8000';
  final Map<String, String> customHeaders = {
    "content-type": "application/json"
  };
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final app = Firebase.initializeApp();
  // User? _userFromFirebaseUser(fb.User? user) {
  //   return user != null
  //       ? User(
  //           uid: user.uid, userName: user.displayName ?? "name not specified")
  //       : null;
  // }
  Future<fb.User> signInEmailAndPass(String email, String password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(authResult);
      if (authResult.user != null) {
        return authResult.user!;
      } else {
        print(
            "--------------------------------------Invalid User --------------------------------");
        throw "Invalid user";
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    throw "An error occured";
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fb.User? user = authResult.user;
      return authResult.user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future<User> signUp(String uniqueId, String password) async {
    await Future.delayed(Duration(seconds: 5));
    throw "error";
    try {} catch (e) {}
  }

  Future signIn(String uniqueId, String password) async {
    Response response = await post(Uri.parse("$serverAddress/users/signin"),
        headers: customHeaders,
        body: jsonEncode({"uniqueId": uniqueId, "password": password}));

    if (response.statusCode == 200) {}
    print(response.body);
  }
}
