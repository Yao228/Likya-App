class TransactionList {
  final String id;
  final double amount;
  final String description;
  final String timestamp;
  final String method;

  TransactionList({
    required this.id,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.method,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'description': description,
      'timestamp': timestamp,
      'method': method,
    };
  }

  factory TransactionList.fromMap(Map<String, dynamic> map) {
    return TransactionList(
      id: map['_id'] as String,
      amount: map['amount'] as double,
      description: map['description'] as String,
      timestamp: map['timestamp'] as String,
      method: map['method'] as String,
    );
  }
}
