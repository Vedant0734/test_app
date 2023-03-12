class TemporaryQuestion {
  String description;
  String option1;
  String option2;
  String option3;
  String option4;

  TemporaryQuestion({this.description="", this.option1="", this.option2="", this.option3="", this.option4=""});
  Map<String, dynamic> toJson() => {
    "option1": option1,
    "option2": option2,
    "option3": option3,
    "option4": option4,
    "description": description
  };
}