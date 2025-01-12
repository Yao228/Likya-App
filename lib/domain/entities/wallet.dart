class WalletEntity {
  final String id;
  final Object user;
  final String balance;
  final String currency;
  final String walletNumber;
  final String status;
  final String createdAt;
  final String updatedAt;

  WalletEntity({
    required this.id,
    required this.user,
    required this.balance,
    required this.currency,
    required this.walletNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
