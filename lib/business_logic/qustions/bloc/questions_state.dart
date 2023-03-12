part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState {
  final List<Question> questions;

  const QuestionsState(this.questions);
}

class QuestionsInitial extends QuestionsState {
  const QuestionsInitial(super.questions);
}

class AnswerUpdatedState extends QuestionsState {
  final int updatedQuestionId;
  const AnswerUpdatedState(super.questions, {required this.updatedQuestionId});
}