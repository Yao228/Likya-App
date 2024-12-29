class ResendotpReqParams {
  final String phonenumber;

  ResendotpReqParams({
    required this.phonenumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenumber': phonenumber,
    };
  }
}
