class Quiz {
  late String title, id, description, subject;
  final int year, noOfQuestions, timeInSeconds;
  final DateTime? createdOn, deadLineOfSubmission;

  Quiz({
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
        id: json["id"] ?? "id not found",
        noOfQuestions: json["noOfQuestions"] ?? -1,
        title: json["quizTitle"] ?? "title not found",
        createdOn: DateTime.now(),
        year: json["year"] ?? 2,
        deadLineOfSubmission: json["deadLineOfSubmission"] != null
            ? DateTime.parse(json["deadLineOfSubmission"])
            : null,
        timeInSeconds: json["time"] ?? 100);
  }
}
