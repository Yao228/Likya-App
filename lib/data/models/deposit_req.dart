class DepositReqParams {
  final double amount;
  final String walletId;
  final String reason;
  final String description;

  DepositReqParams({
    required this.amount,
    required this.walletId,
    required this.reason,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'wallet_id': walletId,
      'reason': reason,
      'description': description,
    };
  }
}
