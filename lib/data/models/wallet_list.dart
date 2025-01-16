class WalletList {
  final String id;
  final double balance;
  final String currency;
  final String walletNumber;
  final String status;
  final String createdAt;
  final String updatedAt;

  WalletList({
    required this.id,
    required this.balance,
    required this.currency,
    required this.walletNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'balance': balance,
      'currency': currency,
      'walletNumber': walletNumber,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory WalletList.fromMap(Map<String, dynamic> map) {
    return WalletList(
      id: map['_id'] as String,
      balance: map['balance'] as double,
      currency: map['currency'] as String,
      walletNumber: map['wallet_number'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
