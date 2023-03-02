import 'package:bgi_test_app/models/question_model.dart';

import '../../services/quiz_service.dart';

class QuizRepository {
  
  final QuizService _quizService = QuizService();

  Future<List<Question>> getQuestions(String quizId) async {
    try {
      final list = await _quizService.getQuestions(quizId);
      final questionsList =  list.map((e) => Question.fromJson(e)).toList();
      return questionsList;
    } catch (e) {
      rethrow;
    }
  }


  Future submitQuiz(String quizId) async {
    try {
      await _quizService.submitQuiz(quizId);
    } catch (e) {
      rethrow;
    }
  }
}