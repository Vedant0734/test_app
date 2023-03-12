part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {
  final Quiz quiz;

  const QuizState(this.quiz);
}

class QuizInitial extends QuizState {
  const QuizInitial(super.quiz);
}

class QuestionsLoadInProgress extends QuizState {
  const QuestionsLoadInProgress(super.quiz);
}

class QuestionsLoadFailedState extends QuizState {
  final String reason;

  const QuestionsLoadFailedState(super.quiz, {this.reason="Something went wrong."});
}

class QuestionsLoadedState extends QuizState {
  final List<Question> questions;

  const QuestionsLoadedState(super.quiz, this.questions);
}

class QuizSubmitInProgress extends QuizState {
  const QuizSubmitInProgress(super.quiz);
}
class QuizSubmitFailed extends QuizState {
  final String reason;
  const QuizSubmitFailed(super.quiz, {this.reason="Something went wrong."});
}
class QuizSubmitSuccess extends QuizState {
  const QuizSubmitSuccess(super.quiz);
}
