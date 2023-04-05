class RoleModel {
  String? roleName;

  RoleModel({this.roleName});

  RoleModel.fromJson(Map<String, dynamic> json) {
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleName'] = roleName;
    return data;
  }
}