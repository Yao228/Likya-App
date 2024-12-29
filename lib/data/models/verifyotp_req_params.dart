class VerifyotpReqParams {
  final String phonenumber;
  final String otpCode;

  VerifyotpReqParams({
    required this.phonenumber,
    required this.otpCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenumber': phonenumber,
      'otp_code': otpCode,
    };
  }
}
