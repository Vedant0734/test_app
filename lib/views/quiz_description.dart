import 'package:bgi_test_app/views/home/student_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../business_logic/quiz/quiz.dart';

class QuizDescriptionScreen extends StatelessWidget {
  final Quiz quiz;
  const QuizDescriptionScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
