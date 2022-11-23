class LoginRequestModel {
  LoginRequestModel({this.email, this.password});
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
    };
    return map;
  }
}
