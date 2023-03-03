class Quiz {
  final String title, id, description, subject;
  final int year, noOfQuestions, timeInSeconds;
  final DateTime? createdOn, deadLineOfSubmission;

  Quiz({
    required this.subject,
    required this.year,
    required this.timeInSeconds,
    required this.createdOn,
    required this.deadLineOfSubmission,
    required this.description,
    required this.id,
    required this.noOfQuestions,
    required this.title,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
        description: json["quizDesc"] ?? "description not found",
        id: json["quiz_id"],
        noOfQuestions: json["num_question"],
        title: json["title"] ?? "title not found",
        subject: json["sub"],
        createdOn: DateTime.parse(json["created_on"]),
        year: json["year"],
        deadLineOfSubmission: json["expire_date"] != null
            ? DateTime.parse(json["expire_date"])
            : null,
        timeInSeconds: json["time"] ?? 10000);
  }
}
