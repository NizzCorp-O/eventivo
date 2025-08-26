class LoginModel {
  final String name;
  final String email;
  final String password;

  LoginModel({required this.name, required this.password, required this.email});

  // Map<String, dynamic> toJson() {
  //   return {'email': email, 'password': password};
  // }

  // factory LoginModel.fromJson(Map<String, dynamic> json) {
  //   return LoginModel(email: json['email'], password: json['password']);
  // }
}
