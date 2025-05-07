


class RegisterResponseModel {
  final String token;

  RegisterResponseModel({
    required this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json['token'],
    );
  }
}