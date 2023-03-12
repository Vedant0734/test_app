part of 'new_quiz_bloc.dart';

@immutable
abstract class NewQuizState {
  final List<TemporaryQuestion> questions;
  final TemporaryQuiz quiz;
  const NewQuizState({required this.questions, required this.quiz});
}

class NewQuizInitial extends NewQuizState {
  const NewQuizInitial({required super.questions, required super.quiz});
}

class QuestionAddedState extends NewQuizState {
  const QuestionAddedState({required super.questions, required super.quiz});
}

class QuizCreationInProgress extends NewQuizState {
  const QuizCreationInProgress({required super.questions, required super.quiz});
}

class QuizCreationSuccess extends NewQuizState {
  final Quiz createdQuiz;
  const QuizCreationSuccess({required super.questions, required super.quiz, required this.createdQuiz});
}

class QuizCreationFailed extends NewQuizState {
  final String reason;
  const QuizCreationFailed({required super.questions, required super.quiz, this.reason="Something went wrong."});
}