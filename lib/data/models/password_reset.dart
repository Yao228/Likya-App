class PasswordResetParams {
  final String newPassword;
  final String confirmPassword;
  final String codeOtp;
  final String phonenumber;

  PasswordResetParams({
    required this.newPassword,
    required this.confirmPassword,
    required this.codeOtp,
    required this.phonenumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_password': newPassword,
      'confirm_password': confirmPassword,
      'code_otp': codeOtp,
      'phonenumber': phonenumber,
    };
  }
}
