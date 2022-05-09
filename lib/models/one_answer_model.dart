import 'dart:convert';

OneAnswerModel welcomeFromJson(String str) =>
    OneAnswerModel.fromJson(json.decode(str));

String welcomeToJson(OneAnswerModel data) => json.encode(data.toJson());

class OneAnswerModel {
  OneAnswerModel({
    this.id,
    this.question,
    this.answers,
    this.rightAnswer,
  });

  int? id;
  String? question;
  List<String>? answers;
  String? rightAnswer;

  OneAnswerModel copyWith({
    int? id,
    String? question,
    List<String>? answers,
    String? rightAnswer,
  }) =>
      OneAnswerModel(
        id: id ?? this.id,
        question: question ?? this.question,
        answers: answers ?? this.answers,
        rightAnswer: rightAnswer ?? this.rightAnswer,
      );

  factory OneAnswerModel.fromJson(Map<String, dynamic> json) => OneAnswerModel(
        id: json['id'],
        question: json['question'],
        answers: json['answers'] == null
            ? null
            : List<String>.from(json['answers'].map((x) => x)),
        rightAnswer: json['rightAnswer'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answers':
            answers == null ? null : List<dynamic>.from(answers!.map((x) => x)),
        'rightAnswer': rightAnswer,
      };
}
