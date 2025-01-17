import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/transaction_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class TransactionApiService {
  Future<Either> addTransaction(
      TransactionReqParams transactionReq, String method);
}

class TransactionApiServiceImpl extends TransactionApiService {
  @override
  Future<Either> addTransaction(
      TransactionReqParams transactionReq, String method) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().post(ApiUrls.transactions,
          queryParameters: {'method': method},
          data: transactionReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
