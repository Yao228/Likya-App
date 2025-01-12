import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/wallet.dart';
import 'package:likya_app/service_locator.dart';

class GetWalletsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<WalletRepository>().getWallets();
  }
}
