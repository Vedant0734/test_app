
import 'package:bgi_test_app/business_logic/password_change_cubit/cubit/password_change_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final TextEditingController currentPasswordController,
      newPasswordController;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    newPasswordController = TextEditingController();
    currentPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PasswordChangeCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Change Password"),
          ),
          body: BlocListener<PasswordChangeCubit, PasswordChangeState>(
            listener: (context, state) {
              if(state is PasswordChangeFailedState){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.reason)));
              } else if(state is PasswordChangeInProgress){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const[
                      Center(child: CircularProgressIndicator(),),
                    ],
                  ),
                ),);
              } else if(state is PasswordChangeSuccess){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                    content: Text("Password changed successfully")
                  )
                );
                currentPasswordController.clear();
                newPasswordController.clear();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 17.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                            "Enter your current password so that we can verify."),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    PasswordTextField(hint: "Current Password", controller: currentPasswordController),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      key: formkey,
                      child: PasswordTextField(
                        validator: (value) {
                          if(value == null){
                            return "Password cannot be empty.";
                          }
                          else if(value.length < 6){
                            return "Password must be 6 characters long.";
                          }
                          return null;
                        },
                        hint: "New Password", controller: newPasswordController)),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formkey.currentState!.validate()){
                          // context.read<PasswordChangeCubit>().changePassword(currentPasswordController.text.trim(), newPasswordController.text.trim());
                        }
                      }, 
                      child: const Text("Change password")
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator
  }) : super(key: key);
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hint;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !isPasswordVisible,
      autocorrect: false,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            isPasswordVisible = !isPasswordVisible;
          }), 
          icon: isPasswordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
        ),
      ),
    );
  }
}
