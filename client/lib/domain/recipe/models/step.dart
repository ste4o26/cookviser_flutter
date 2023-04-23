class StepModel {
  int number;
  String content;

  StepModel({required this.number, required this.content});

  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      number: json['number'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['content'] = content;
    return data;
  }
}
