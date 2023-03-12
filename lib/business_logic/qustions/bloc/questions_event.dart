part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class QuestionAnswered extends QuestionsEvent {
  final String answer;
  final int questionId;
  QuestionAnswered({required this.answer, required this.questionId});  
}