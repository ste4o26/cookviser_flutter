class UserLoginViewModel {
  String username;
  String password;

  UserLoginViewModel({
    this.username = "",
    this.password = "",
  });

  factory UserLoginViewModel.fromJson(Map<String, dynamic> json) {
    return UserLoginViewModel(
        username: json['username'],
        password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}