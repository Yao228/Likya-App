class TransactionReqParams {
  final double amount;
  final String walletId;
  final String reason;
  final String description;
  final String transactionReceiver;

  TransactionReqParams({
    required this.amount,
    required this.walletId,
    required this.reason,
    required this.description,
    required this.transactionReceiver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "amount": amount,
      "wallet_id": walletId,
      "reason": reason,
      "description": description,
      "transaction_receiver": transactionReceiver
    };
  }
}
