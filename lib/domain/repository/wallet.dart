import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/add_wallet_req.dart';

abstract class WalletRepository {
  Future<Either> addWallet(AddWalletReqParams walletReq);
  Future<Either> getWallets();
}
