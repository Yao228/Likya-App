class DepositReqParams {
  final double amount;
  final String walletId;
  final String reason;
  final String description;
  final String returnUrl;

  DepositReqParams({
    required this.amount,
    required this.walletId,
    required this.reason,
    required this.description,
    required this.returnUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'wallet_id': walletId,
      'reason': reason,
      'description': description,
      'return_url': returnUrl,
    };
  }
}
