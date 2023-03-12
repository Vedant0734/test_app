import 'package:bgi_test_app/business_logic/quiz/quiz.dart';
import 'package:bgi_test_app/business_logic/quiz/repo.dart';
import 'package:bgi_test_app/models/temp_question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../temp_quiz_model.dart';
part 'new_quiz_event.dart';
part 'new_quiz_state.dart';

class NewQuizBloc extends Bloc<NewQuizEvent, NewQuizState> {
  final QuizRepository _quizRepository = QuizRepository();
  NewQuizBloc() : super(NewQuizInitial(quiz: TemporaryQuiz(), questions: [TemporaryQuestion()])) {
    on<NewQuizEvent>((event, emit) {
      
    });
    on<CreateQuiz>((event, emit) async {
      try {
        final quiz = await _quizRepository.createQuiz(state.quiz, state.questions);
        
      } catch (e) {
        emit(QuizCreationFailed(questions: state.questions, quiz: state.quiz));
      }
    });
    on<AddQuestion>((event, emit) {
      List<TemporaryQuestion> newList = List.from(state.questions);
      newList.add(TemporaryQuestion());
      emit(QuestionAddedState(questions: newList, quiz: state.quiz));
    });
  }
}
