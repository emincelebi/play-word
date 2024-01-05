class QuestionModel {
  int? id;
  String? question;
  String? answer;

  QuestionModel({this.id, this.question, this.answer});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
