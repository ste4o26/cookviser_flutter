class StepModel {
  int? number;
  String? content;

  StepModel({this.number, this.content});

  StepModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['content'] = content;
    return data;
  }
}