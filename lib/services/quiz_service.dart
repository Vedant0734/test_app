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



  Future submitQuiz(String quizId, Map<String, dynamic> answers, bool isTerminated) async {
    print("the answers");
    print(answers.entries);
    await Future.delayed(const Duration(seconds: 3));
    throw "d";
    final reqBody = jsonEncode({
        "quizId": quizId, 
        "isTerminated": isTerminated,
        "answers": answers
      });
    Response response =
        await post(Uri.parse("$serverAddress/submissions/$quizId"), 
          headers: customHeaders,
          body: reqBody
        );
    if (response.statusCode == 500) {
      throw Exception("Something went wrong.");
    } else if (response.statusCode == 404) {
      throw QuizNotFoundError(quizId);
    }
  }

  Future<Map<String, dynamic>> createQuiz(Map<String, dynamic> quizData, List<Map<String, dynamic>> questionData) async {
    final reqBody = jsonEncode({
      "quiz": quizData,
      "questions": questionData
    });
    print("the quiz to create is");
    print(quizData);
    print(questionData);
    Response response = await post(Uri.parse("${serverAddress}/quiz"), 
      headers: customHeaders,
      body: reqBody
    );

    if(response.statusCode == 500 
    || response.statusCode == 401
    || response.statusCode == 400){
      throw "Something went wrong.";
    }
    Map<String, dynamic> result = jsonDecode(response.body);
    return result;
  }
}
