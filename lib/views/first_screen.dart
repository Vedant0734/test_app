import 'package:bgi_test_app/views/As_admin.dart';
import 'package:bgi_test_app/views/signup.dart';
import 'package:flutter/cupertino.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
        SignIn(
          pageController: pageController,
        ),
        SignUp(
          pageController: pageController,
        )
      ],
    );
  }
}
