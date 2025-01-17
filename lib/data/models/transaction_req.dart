class TransactionReqParams {
  final int amount;
  final String comment;

  TransactionReqParams({
    required this.amount,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'comment': comment,
    };
  }
}
