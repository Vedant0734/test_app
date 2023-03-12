class TemporaryQuiz {
  String title, description, subject;
  int? year;
  int timeInHours, timeInMinutes;
  DateTime? deadLineOfSubmission;

  TemporaryQuiz({this.title="", this.description="", this.subject="", this.year, this.timeInHours=0, this.timeInMinutes=0, this.deadLineOfSubmission});

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "subject": subject,
    "year": year,
    "time": (timeInHours*60*60) + (timeInMinutes * 60),
    "deadline": deadLineOfSubmission
  };
}