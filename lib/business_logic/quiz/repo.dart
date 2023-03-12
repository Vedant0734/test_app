import 'package:bgi_test_app/business_logic/quiz/new_quiz/temp_quiz_model.dart';
import 'package:bgi_test_app/business_logic/qustions/question_model.dart';
import 'package:random_string/random_string.dart';

import '../../models/temp_question_model.dart';
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


  Future submitQuiz(String quizId, Map<String, dynamic> answers, bool isTerminated) async {
    try {
      await _quizService.submitQuiz(quizId, answers, isTerminated);
    } catch (e) {
      rethrow;
    }
  }

  Future createQuiz(TemporaryQuiz quiz, List<TemporaryQuestion> questions) async {
    try {
      Map<String, dynamic> quizData = quiz.toJson();
      String quizId = randomAlphaNumeric(10);
      quizData["quizId"] = quizId;
      List<Map<String, dynamic>> questionData = questions.map((e) => e.toJson()).toList();
      Map<String, dynamic> result = await _quizService.createQuiz(quizData, questionData);
    } catch (e) {
      rethrow;
    }
  }
}