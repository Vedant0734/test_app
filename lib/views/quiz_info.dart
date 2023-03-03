import 'package:bgi_test_app/models/quiz.dart';
import 'package:bgi_test_app/views/quiz_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/quiz/bloc/quiz_bloc.dart';

class QuizInfo extends StatelessWidget {
  final Quiz quiz;
  const QuizInfo({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: Builder(builder: (context) {
        return BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuestionsLoadInProgress) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        strokeWidth: 2.1,
                      )
                    ],
                  ),
                ),
              );
            } else if (state is QuestionsLoadedState) {
              final quizBloc = context.read<QuizBloc>();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: quizBloc,
                      child: QuizPlay(quiz: quiz, questions: state.questions),
                    ),
                  ));
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(LoadQuestionsEvent("1"));
                    },
                    child: const Text("Start quiz"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
