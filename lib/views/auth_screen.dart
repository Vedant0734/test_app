import 'package:bgi_test_app/views/sign_in_screens/signin_screen.dart';
import 'package:bgi_test_app/views/signup.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      allowImplicitScrolling: false,
      controller: pageController,
      children: [
        SignInScreen(
          pageController: pageController,
        ),
        SignUp(
          pageController: pageController,
        )
      ],
    );
  }
}
