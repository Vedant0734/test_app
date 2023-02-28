import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';

class DatabaseService {
  // final String uid;
  late FirebaseFirestore database;
  final String serverAddress = 'http://192.168.43.149:8000';
  // DatabaseService({required this.uid});
  DatabaseService() {
    database = FirebaseFirestore.instance;
  }

  Future<void> addUser(Map<String, dynamic> userData) async {
    await database.collection("users").add(userData).catchError((e) {
      print(e);
      throw e;
    });
  }

  getData() async {
    return database.collection("users").snapshots;
    // FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await database.collection("QUIZ").doc(quizId).set({
      "id": quizId,
      "noOfQuestions": quizData["noOfQuestions"],
      "description": quizData["description"],
      "title": quizData["title"]
    });
  }

  Future<void> addQuestionData(
      Map<String, dynamic> questionData, String quizId) async {
    await database
        .collection("QUIZ")
        .doc(quizId)
        .collection("questions")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  // Future<List<Map<String, dynamic>>> getQuizData() async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await database.collection("QUIZ").get();
  //   // database.collection("QUIZ").doc
  //   print("incoming data");
  //   final result = await database.collection("QUIZ").snapshots();
  //   print(querySnapshot.docs.length);
  //   List<Map<String, dynamic>> docList = [];

  //   for (var element in querySnapshot.docs) {
  //     docList.add(element.data());
  //     print(element.data());
  //   }
  //   return docList;
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuestionData(
      String quizId) async {
    QuerySnapshot<Map<String, dynamic>> data = await database
        .collection("QUIZ")
        .doc(quizId)
        .collection('questions')
        .get();
    print("getting question data");
    for (var element in data.docs) {
      print(element.data());
    }
    print("done");
    return data;
    // return await FirebaseFirestore.instance
    //     .collection("Quiz")
    //     .doc(quizId)
    //     .collection("QNA")
    //     .get();
  }

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
}

class QuizNotFoundError {
  final String quizId;

  QuizNotFoundError(this.quizId);
}
