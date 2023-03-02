import 'package:bgi_test_app/business_logic/quiz/repo.dart';
import 'package:bgi_test_app/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../errors/quiz_not_found.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository =  QuizRepository();
  QuizBloc() : super(QuizInitial()) {
    on<LoadQuestionsEvent>((event, emit) async {
      emit(QuestionsLoadInProgress());
      try {
        final questions = await _quizRepository.getQuestions(event.quizId);
        emit(QuestionsLoadedState(questions));
      } on QuizNotFoundError {
        emit(QuestionsLoadFailedState(
            reason: "The requested quiz was not found."));
      } catch (e) {
        print(e.toString());
        emit(QuestionsLoadFailedState());
      }
    });
    on<SubmitQuiz>((event, emit) async {
      try {
        // await _quizRepository.submitQuiz();
      } catch (e) {
        
      }
    });
  }
}
