part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class LoadQuestionsEvent extends QuizEvent {
  final String quizId;

  LoadQuestionsEvent(this.quizId);
}

class SubmitQuiz extends QuizEvent {
  final List<Question> questions;
  final bool isTerminated;
  SubmitQuiz(this.questions, {this.isTerminated=false});
}