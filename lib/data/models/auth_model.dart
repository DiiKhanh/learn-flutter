class AuthModel {
  String? accountName;
  String? password;
  String? token;

  AuthModel({this.accountName, this.password, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = accountName;
    data['password'] = password;
    return data;
  }
}
