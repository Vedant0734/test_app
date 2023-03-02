import 'dart:convert';
import 'package:http/http.dart';
import '../business_logic/errors/quiz_not_found.dart';

class QuizService {
  
  final String serverAddress = 'http://192.168.43.149:8000';
  final Map<String, String> customHeaders = {
    "content-type": "application/json"
  };

  Future<List<Map<String, dynamic>>> getQuestions(String quizId) async {
    Response response =
        await get(Uri.parse("$serverAddress/questions/$quizId"));
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      List<Map<String, dynamic>> formattedResult =
          result.map((e) => e as Map<String, dynamic>).toList();
      return formattedResult;
    } else if (response.statusCode == 404) {
      throw QuizNotFoundError(quizId);
    } else if (response.statusCode == 500) {
      throw "Something went wrong";
    } else {
      throw "Response code did not match";
    }
  }



  Future submitQuiz(String quizId) async {

  }

}