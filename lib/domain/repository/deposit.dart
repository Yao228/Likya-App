import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/deposit_req.dart';

abstract class DepositRepository {
  Future<Either> addDeposit(DepositReqParams depositReq, String depositParam);
}
