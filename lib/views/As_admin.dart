import 'package:bgi_test_app/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth.dart';
import '../widget/widget.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  final PageController pageController;

  const SignIn({super.key, required this.pageController});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: emailEditingController,
                    decoration: InputDecoration(hintText: "Unique ID"),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextField(
                    controller: passwordEditingController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 20.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      User user = await _authService.signInEmailAndPass(
                          emailEditingController.text.trim(),
                          passwordEditingController.text.trim());
                      // _authService.signIn(emailEditingController.text.trim(),
                      //     passwordEditingController.text.trim());
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(user: user)),
                          (route) => false);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? ',
                          style: TextStyle(
                              color: Color.fromARGB(221, 26, 24, 24),
                              fontSize: 17)),
                      GestureDetector(
                        onTap: () {
                          widget.pageController.animateToPage(1,
                              duration: Duration(seconds: 1),
                              curve: Curves.bounceOut);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => SignUp(),
                          //     ));
                        },
                        child: Container(
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline,
                                  fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
