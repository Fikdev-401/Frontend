class LoginResponseModel {
  final int id;
  final String token;
  final String name;
  final String email;

  LoginResponseModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['user'] == null) {
      throw Exception("User data is required in login response");
    }
    
    final userData = json['user'];
    if (userData['id'] == null) {
      throw Exception("User ID is required in login response");
    }

    return LoginResponseModel(
      id: userData['id'],
      token: json['token'],
      name: userData['name'],
      email: userData['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
    };
  }
}