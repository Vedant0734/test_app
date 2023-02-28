import 'package:bgi_test_app/models/question_model.dart';
import 'package:bgi_test_app/models/quiz.dart';
import 'package:bgi_test_app/services/database.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final DatabaseService _databaseService = DatabaseService();
  QuizBloc() : super(QuizInitial()) {
    on<LoadQuestionsEvent>((event, emit) async {
      emit(QuestionsLoadInProgress());
      try {
        final questions = await _databaseService.getQuestions(event.quizId);
        List<Question> questionsList =
            questions.map((e) => Question.fromJson(e)).toList();
        emit(QuestionsLoadedState(questionsList));
      } on QuizNotFoundError {
        emit(QuestionsLoadFailedState(
            reason: "The requested quiz was not found."));
      } catch (e) {
        print(e.toString());
        emit(QuestionsLoadFailedState());
      }
    });
  }
}
