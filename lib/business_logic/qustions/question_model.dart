class Question {
  final String quizId;
  final int questionId;
  final String description;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final bool isAnswered;
  final String? answer;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        questionId: json["id"],
        quizId: json["qId"],
        option1: json["opt1"],
        option2: json["opt2"],
        option3: json["opt3"],
        option4: json["opt4"],
        description: json["descr"]);
  }

  Question(
      {required this.questionId,
      required this.quizId,
      required this.description,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      this.answer,
      this.isAnswered = false});

  Question copyWithAnswer(String newAnswer) {
    return Question(
      questionId: questionId, 
      quizId: quizId, 
      description: description,
      option1: option1,
      option2: option2,
      option3: option3,
      option4: option4,
      answer: newAnswer,
      isAnswered: true
    );
  }
}
