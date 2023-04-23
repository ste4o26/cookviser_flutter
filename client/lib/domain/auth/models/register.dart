class UserRegisterViewModel {
  String username;
  String email;
  String description;
  String password;
  String confirmPassword;

  UserRegisterViewModel({
    this.username = '',
    this.email = '',
    this.description = '',
    this.password = '',
    this.confirmPassword = '',
  });

  factory UserRegisterViewModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterViewModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['description'] = description;
    return data;
  }
}
