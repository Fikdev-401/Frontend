

class LoginResponseModel {
  final int id;
  final String token;

  LoginResponseModel({
    required this.id,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] ?? -1,
      token: json['token'],
    );
  }
}