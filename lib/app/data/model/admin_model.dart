class AdminModel {
  final String id;
  final String name;
  final String username;
  final String password;

  const AdminModel({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'username': this.username,
      'password': this.password,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}