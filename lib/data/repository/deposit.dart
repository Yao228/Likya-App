import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/deposit_req.dart';
import 'package:likya_app/data/source/deposit_api_service.dart';
import 'package:likya_app/domain/repository/deposit.dart';
import 'package:likya_app/service_locator.dart';

class DepositRepositoryImpl extends DepositRepository {
  @override
  Future<Either> addDeposit(
      DepositReqParams depositReq, String depositParam) async {
    return sl<DepositApiService>().addDeposit(depositReq, depositParam);
  }
}
