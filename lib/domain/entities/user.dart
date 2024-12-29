class UserEntity {
  final String id;
  String? fullname;
  final String phonenumber;
  String? email;
  final Object role;
  final bool isActive;
  final Object attributes;

  UserEntity({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.role,
    required this.isActive,
    required this.attributes,
  });
}
