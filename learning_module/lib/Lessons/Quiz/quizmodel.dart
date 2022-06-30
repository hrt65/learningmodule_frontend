//@dart=2.9

class QuizModel {
  int id;
  String title;
  String creator;
  List<QuesModel> questionlist;
  QuizModel({this.id, this.title, this.creator, this.questionlist});
  factory QuizModel.fromJson(Map<dynamic, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['quiz_title'].toString(),
      creator: json['quiz_creator'],
      questionlist: json['quiz_question']
          .map<QuesModel>((json) => QuesModel.fromJson(json))
          .toList(),
    );
  }
}

class QuesModel {
  int id;
  String text;
  String option1;
  String option2;
  String option3;
  String option4;
  String answer;
  QuesModel(
      {this.id,
      this.text,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.answer});
  factory QuesModel.fromJson(Map<dynamic, dynamic> json) {
    return QuesModel(
        id: json['id'],
        text: json['question_text'].toString(),
        option1: json['option1'],
        option2: json['option2'],
        option3: json['option3'],
        option4: json['option4']);
  }
}

// QuizModel quiz;
// print(quiz.title);
// print(quiz.questionlist[0].option1)