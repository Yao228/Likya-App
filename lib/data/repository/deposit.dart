import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/deposit_req.dart';
import 'package:likya_app/data/source/deposit_api_service.dart';
import 'package:likya_app/domain/repository/deposit.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

class DepositRepositoryImpl extends DepositRepository {
  @override
  Future<Either> addDeposit(
      DepositReqParams depositReq, String depositParam) async {
    Either result = await sl<DepositApiService>().addDeposit(depositReq, depositParam);
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      LocalStorageService.putString(LocalStorageService.payementUrl, response.data['payment_url']);
      LocalStorageService.putString(LocalStorageService.depositAmount, response.data['amount'].toString());
      LocalStorageService.putString(LocalStorageService.transactionId, response.data['transaction_id']);
      return Right(response);
    });
  }
}
