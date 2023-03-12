import 'package:bgi_test_app/business_logic/qustions/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final List<Question> questions;
  QuestionsBloc({required this.questions}) : super(QuestionsInitial(questions)) {
    on<QuestionAnswered>((event, emit) {
      final questionToUpdate = state.questions.firstWhere((element) => element.questionId == event.questionId);
      if(questionToUpdate.answer != event.answer){
        final answeredQestion = questionToUpdate.copyWithAnswer(event.answer);
        emit(AnswerUpdatedState(_updateQuestions(state.questions, answeredQestion), updatedQuestionId: event.questionId));
        for (var element in state.questions) {
          print(element.answer);
        }
      }
    });
  }

  List<Question> _updateQuestions(List<Question> questions, Question questionToUpdate) {
    List<Question> result = [];
    for (var question in questions) {
      if(question.questionId == questionToUpdate.questionId){
        result.add(questionToUpdate);
      } else {
        result.add(question);
      }
    }
    return result;
  }
}
