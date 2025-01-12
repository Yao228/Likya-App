import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/add_wallet_req.dart';
import 'package:likya_app/data/models/wallet_list.dart';
import 'package:likya_app/data/source/wallet_api_service.dart';
import 'package:likya_app/domain/repository/wallet.dart';
import 'package:likya_app/service_locator.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<Either> addWallet(AddWalletReqParams walletReq) async {
    return sl<WalletApiService>().addWallet(walletReq);
  }

  @override
  Future<Either> getWallets() async {
    Either result = await sl<WalletApiService>().getWallets();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var walletLists = (response.data["items"] as List)
            .map((item) => WalletList.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(walletLists);
      },
    );
  }
}
