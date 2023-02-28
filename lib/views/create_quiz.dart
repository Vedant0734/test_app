// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/database.dart';
import '../views/add_question.dart';
import '../widget/widget.dart';
import 'package:random_string/random_string.dart';

// ignore: use_key_in_widget_constructors
class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  // ignore: unnecessary_new
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  late String quizDate, quizTitle, quizDesc;

  bool isLoading = false;
  late String quizId;

  createQuiz() {
    quizId = randomAlphaNumeric(16);

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> quizData = {
        "quizdate": quizDate,
        "title": quizTitle,
        "description": quizDesc,
        "noOfQuestions": 0
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val!.isEmpty ? "Quiz date" : null,
                decoration: InputDecoration(hintText: "Quiz date (Optional)"),
                onChanged: (val) {
                  quizDate = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: InputDecoration(hintText: "Quiz Description"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
