class LoginReqParams {
  final String phonenumber;
  final String password;

  LoginReqParams({
    required this.password,
    required this.phonenumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenumber': phonenumber,
      'password': password,
    };
  }
}
