class DataUser {
  final User data;

  DataUser({required this.data});

  factory DataUser.fromJson(Map<String, dynamic> json) {
  if (json['data'] == null) {
    throw Exception("User data is null");
  }

  return DataUser(
    data: User.fromJson(json['data']),
  );
}

}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  // factory untuk parsing dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
