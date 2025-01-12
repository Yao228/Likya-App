import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/add_wallet_req.dart';
import 'package:likya_app/domain/repository/wallet.dart';
import 'package:likya_app/service_locator.dart';

class AddWalletUseCase implements Usecase<Either, AddWalletReqParams> {
  @override
  Future<Either> call({AddWalletReqParams? param}) async {
    return sl<WalletRepository>().addWallet(param!);
  }
}
