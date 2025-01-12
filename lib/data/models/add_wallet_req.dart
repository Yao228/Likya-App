class AddWalletReqParams {
  final String userId;

  AddWalletReqParams({
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
    };
  }
}
