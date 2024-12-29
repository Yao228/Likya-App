class PasswordReqParams {
  final String phonenumber;

  PasswordReqParams({
    required this.phonenumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenumber': phonenumber,
    };
  }
}
