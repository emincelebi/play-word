class QuestionModel {
  int? id;
  String? question;
  String? answer;
  String? level;
  String? isKnown;
  String? isStar;

  QuestionModel({this.id, this.question, this.answer, this.level, this.isKnown, this.isStar});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    level = json['level'];
    isKnown = json['isKnown'];
    isStar = json['isStar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['level'] = level;
    data['isKnown'] = isKnown;
    data['isStar'] = isStar;
    return data;
  }
}
