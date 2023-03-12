import 'package:bgi_test_app/models/user.dart';
import 'package:bgi_test_app/services/database.dart';
import 'package:bgi_test_app/views/profile_page.dart';
import 'package:bgi_test_app/views/quiz_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../helper/widgets/custom_drawer.dart';
import '../../business_logic/quiz/quiz.dart';
import '../../widget/widget.dart';
import '../../routes.dart' as route;

class StudentHome extends StatefulWidget {
  final User user;

  const StudentHome({super.key, required this.user});
  @override
  State <StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

  Widget quizList() {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: widget.user.quizes.length,
            itemBuilder: (context, index) {
              return QuizTile(quiz: widget.user.quizes[index]);
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.grey.shade300,
      ),
      drawer: ReusableDrawer(user: widget.user),
      body: quizList()
    );
  }
}

class QuizTile extends StatelessWidget {
  final Quiz quiz;
  const QuizTile({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizInfo(quiz: quiz)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              // Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              //   width: MediaQuery.of(context).size.width,
              // ),
              Container(
                color: const Color.fromARGB(255, 190, 68, 243),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quiz.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        quiz.description,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
