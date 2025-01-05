import 'package:likya_app/domain/entities/user.dart';

class UserModel {
  final String id;
  String? fullname;
  final String phonenumber;
  String? email;
  final Object role;
  final bool isActive;
  Map<String, dynamic> attributes;

  UserModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.role,
    required this.isActive,
    required this.attributes,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'phonenumber': phonenumber,
      'email': email,
      'role': role,
      'isActive': isActive,
      'attributes': attributes
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      fullname: map['fullname'] as String? ?? '',
      phonenumber: map['phonenumber'] as String,
      email: map['email'] as String?,
      role: map['role'] ?? {},
      isActive: map['is_active'] as bool? ?? false,
      attributes: map['attributes'] as Map<String, dynamic>? ?? {},
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        id: id,
        fullname: fullname,
        phonenumber: phonenumber,
        email: email,
        role: role,
        isActive: isActive,
        attributes: attributes);
  }
}
