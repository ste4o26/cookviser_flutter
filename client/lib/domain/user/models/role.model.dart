class RoleModel {
  String roleName;

  RoleModel({required this.roleName});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      roleName: json['roleName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleName'] = roleName;
    return data;
  }
}
