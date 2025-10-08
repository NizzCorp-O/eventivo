class LoginModel {
  final String name;
  final String email;
  final num phone;
  final String pass;
   final String? profileUrl;

  LoginModel(this.profileUrl, {
    required this.pass,
    required this.name,
    required this.email,
    required this.phone,
  });

  // Map<String, dynamic> toJson() {
  //   return {'email': email, 'password': password};
  // }

  // factory LoginModel.fromJson(Map<String, dynamic> json) {
  //   return LoginModel(email: json['email'], password: json['password']);
  // }
}
