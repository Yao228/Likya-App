import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/add_wallet_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class WalletApiService {
  Future<Either> addWallet(AddWalletReqParams walletReq);
  Future<Either> getWallets();
}

class WalletApiServiceImpl extends WalletApiService {
  @override
  Future<Either> addWallet(AddWalletReqParams walletReq) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().post(ApiUrls.wallets,
          data: walletReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> getWallets() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().get(
        ApiUrls.wallets,
        queryParameters: {
          'sort': 'desc',
          'status': 'active',
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
