import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/quiz/bloc/quiz_bloc.dart';
import 'business_logic/qustions/bloc/questions_bloc.dart';

class OptionTile extends StatefulWidget {
  final String description;
  final int questionId;

  const OptionTile(
      {super.key,
      required this.questionId,
      required this.description});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final quizState = context.read<QuizBloc>().state;
        if(quizState is! QuizSubmitFailed){
          context.read<QuestionsBloc>().add(QuestionAnswered(
            answer: widget.description, questionId: widget.questionId));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(3, 6))
            ],
            color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800.withOpacity(0.7)
                    : Colors.white54,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            BlocBuilder<QuestionsBloc, QuestionsState>(
              buildWhen: (previous, current) {
                if(current is AnswerUpdatedState && current.updatedQuestionId == widget.questionId){
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                final currentQuestion = state.questions.firstWhere((element) => element.questionId == widget.questionId);
                bool isSelected = currentQuestion.answer == widget.description;
                return Container(
                  height: 22,
                  width: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  child: AnimatedOpacity(
                    opacity:
                        isSelected
                            ? 1.0
                            : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      margin: const EdgeInsets.all(1.5),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 25,
            ),
            Flexible(child: Text(widget.description, style: const TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}

class NoOfQuestionTile extends StatelessWidget {
  final String text;
  final int number;

  const NoOfQuestionTile({super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)),
                color: Colors.blue),
            child: Text(
              "$number",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
