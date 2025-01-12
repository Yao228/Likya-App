class UpdatePasswordReqParams {
  final String newPassword;
  final String confirmPassword;

  UpdatePasswordReqParams({
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_password': newPassword,
      'confirm_password': confirmPassword,
    };
  }
}
