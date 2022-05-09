class TrueOrFalseModel {
  int? id;
  String? question;
  bool? rightAnswer;

  TrueOrFalseModel({this.id, this.question, this.rightAnswer});

  factory TrueOrFalseModel.fromJson(Map<String, dynamic> json) =>
      TrueOrFalseModel(
          id: json['id'] == null ? null : json['id'] as int?,
          question:
              json['question'] == null ? null : json['question'] as String?,
          rightAnswer:
              json['rightAnswer'] == null ? null : json['rightAnswer'] as bool);

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'rightAnswer': rightAnswer,
      };
}
