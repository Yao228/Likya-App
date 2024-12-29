class SignupReqParams {
  final String phonenumber;
  final String password;
  final String? role;

  SignupReqParams({
    required this.password,
    required this.phonenumber,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenumber': phonenumber,
      'password': password,
      'role': role,
    };
  }
}
