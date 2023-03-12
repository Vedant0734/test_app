import 'package:bgi_test_app/business_logic/quiz/quiz.dart';
import '../enums/user_type.dart';

class User {
  final String uid, userName, phone;
  final List<Quiz> quizes;
  final UserType userType;
  User({required this.phone, required this.userType, required this.uid, required this.userName, required this.quizes});


  factory User.fromJson(Map<String, dynamic> json){
    List<Map<String, dynamic>> quizList = (json["quizes"] as List).map((e) => e as Map<String, dynamic>).toList();
    List<Quiz> quizes = quizList.map((e) => Quiz.fromJson(e)).toList();
    return User(
      phone: json["user"]["mobileno"], 
      userType: UserType.student, 
      uid: json["user"]["Eno"], 
      userName: json["user"]["name"], 
      quizes: quizes
    );
  }
}



