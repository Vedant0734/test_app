import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../business_logic/sign_up/sign_up_bloc.dart';
import '../helper/constants.dart';
import '../services/auth.dart';
import '../services/database.dart';
import 'home/admin_home.dart';
import '../widget/widget.dart';

class SignUp extends StatefulWidget {
  final PageController pageController;

  const SignUp({super.key, required this.pageController});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  // text feild

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          // backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                BlocListener<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpInProgressState) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.3)),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text("Please wait...")
                            ],
                          ),
                        ),
                      );
                    } else if (state is SignUpFailedState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error"),
                      ));
                    } else if (state is SignUpSuccessState) {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Home(
                      //             // user: state.user,
                      //             )));
                    }
                  },
                  child: const Spacer(),
                ),
                // const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: uniqueIdController,
                        validator: (val) =>
                            val!.isEmpty ? "Please fill this field" : null,
                        decoration:
                            const InputDecoration(hintText: "Enrollement no."),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (val) => val!.length < 5
                            ? "Password must be 5+ characters"
                            : null,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                ?.unfocus();
                            context.read<SignUpBloc>().add(SignUpRequested(
                                uniqueId: uniqueIdController.text.trim(),
                                password: passwordController.text.trim()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 20.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have and account? ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              widget.pageController.animateToPage(0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.bounceOut);
                            },
                            child: Container(
                              child: const Text('Sign In',
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
      }),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? false : true;
}
