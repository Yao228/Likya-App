import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/deposit_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class DepositApiService {
  Future<Either> addDeposit(DepositReqParams depositReq, String depositParam);
}

class DepositApiServiceImpl extends DepositApiService {
  @override
  Future<Either> addDeposit(
      DepositReqParams depositReq, String depositParam) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().post(ApiUrls.deposit,
          queryParameters: {'goto': depositParam},
          data: depositReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
