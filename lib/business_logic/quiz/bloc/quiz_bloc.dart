import 'package:bgi_test_app/business_logic/quiz/repo.dart';
import 'package:bgi_test_app/business_logic/qustions/question_model.dart';
import 'package:bgi_test_app/business_logic/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../errors/quiz_not_found.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final Quiz quiz;
  final QuizRepository _quizRepository =  QuizRepository();
  QuizBloc({required this.quiz}) : super(QuizInitial(quiz)) {
    on<LoadQuestionsEvent>((event, emit) async {
      emit(QuestionsLoadInProgress(state.quiz));
      try {
        final questions = await _quizRepository.getQuestions(event.quizId);
        emit(QuestionsLoadedState(state.quiz, questions));
      } on QuizNotFoundError {
        emit(QuestionsLoadFailedState(
            state.quiz,
            reason: "The requested quiz was not found."));
      } catch (e) {
        print(e.toString());
        emit(QuestionsLoadFailedState(state.quiz));
      }
    });
    on<SubmitQuiz>((event, emit) async {
      emit(QuizSubmitInProgress(state.quiz));
      try {
        Map<String, String?> answers = {} ;
        for (var question in event.questions) {
          answers[question.questionId.toString()] = question.answer;
        }
        await _quizRepository.submitQuiz(state.quiz.id, answers, event.isTerminated);
        emit(QuizSubmitSuccess(state.quiz));
      } catch (e) {
        emit(QuizSubmitFailed(state.quiz));
      }
    });
  }
}
