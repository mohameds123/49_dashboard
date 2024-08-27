import 'base_user.dart';

class ComplaintModel {
  final String id;
  final String? userId;
  final String name;
  final String phone;
  final String description;
  final BaseUser? user;

  const ComplaintModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.description,
    required this.user,
  });

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      id: map['_id'] as String,
      userId: map['user_id'] as String?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      description: map['description'] as String,
      user: map['user'] != null
          ? BaseUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }
}
