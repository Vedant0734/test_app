import 'package:bgi_test_app/business_logic/theme_cubit/cubit/theme_cubit.dart';
import 'package:bgi_test_app/routes.dart';
import 'package:bgi_test_app/views/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
                title: 'BGI Test',
                debugShowCheckedModeBanner: false,
                theme: state.theme.currentTheme,
                onGenerateRoute: controller,
                home: const AuthenticationScreen()
              );
          },
        );
      }),
    );
  }
}
