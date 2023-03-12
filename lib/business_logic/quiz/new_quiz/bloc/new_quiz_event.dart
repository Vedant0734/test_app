part of 'new_quiz_bloc.dart';

@immutable
abstract class NewQuizEvent {}

class AddQuestion extends NewQuizEvent {}

class CreateQuiz extends NewQuizEvent {}
