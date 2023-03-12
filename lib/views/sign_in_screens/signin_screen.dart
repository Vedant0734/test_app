import 'package:bgi_test_app/enums/user_type.dart';
import 'package:bgi_test_app/views/home/student_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/sign_in/bloc/sign_in_bloc.dart';
import '../../services/auth.dart';
import '../../widget/widget.dart';
import '../home/admin_home.dart';

class SignInScreen extends StatefulWidget {
  final PageController pageController;

  const SignInScreen({super.key, required this.pageController});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late final TextEditingController emailEditingController;
  late final TextEditingController passwordEditingController;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController  = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: Builder(builder: (context) {
        return BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {            
            if(state is SignInInProgressState){
              showDialog(context: context, builder: (context) => AlertDialog(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const[
                    Center(child: CircularProgressIndicator(),),
                  ],
                ),
              ),);
            } else if(state is SignInSuccessState){
              if(state.user.userType == UserType.teacher){
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminHome(user: state.user)),
                (route) => false);
              } else {
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentHome(user: state.user)),
                (route) => false);
              }
              
            } else if(state is SignInFailedState){
              if(ModalRoute.of(context)?.isCurrent != true){
                Navigator.pop(context);
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Failed: ${state.reason}")
              ));
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: AppLogo(),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
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
                          onPressed: () {
                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                            context.read<SignInBloc>().add(SignInRequested(
                                uniqueId: emailEditingController.text.trim(),
                                password:
                                    passwordEditingController.text.trim()));
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
                                style: TextStyle(fontSize: 17)),
                            GestureDetector(
                              onTap: () {
                                widget.pageController.animateToPage(1,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.bounceOut);
                              },
                              child: const SizedBox(
                                child: Text('Sign Up',
                                    style: TextStyle(
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
          ),
        );
      }),
    );
  }
}
