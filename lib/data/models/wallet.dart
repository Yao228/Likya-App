import 'package:likya_app/domain/entities/contribution.dart';
import 'package:likya_app/domain/entities/wallet.dart';

class WalletModel {
  final String id;
  final Object user;
  final String balance;
  final String currency;
  final String walletNumber;
  final String status;
  final String createdAt;
  final String updatedAt;

  WalletModel({
    required this.id,
    required this.user,
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
      'user': user,
      'balance': balance,
      'currency': currency,
      'walletNumber': walletNumber,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['_id'] as String,
      user: map['user'] as Object,
      balance: map['balance'] as String,
      currency: map['currency'] as String,
      walletNumber: map['wallet_number'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}

extension WalletXModel on WalletModel {
  WalletEntity toEntity() {
    return WalletEntity(
      id: id,
      user: user,
      balance: balance,
      currency: currency,
      walletNumber: walletNumber,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
