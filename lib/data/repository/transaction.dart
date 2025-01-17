import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/transaction_req.dart';
import 'package:likya_app/data/source/transaction_api_service.dart';
import 'package:likya_app/domain/repository/transaction.dart';
import 'package:likya_app/service_locator.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  @override
  Future<Either> addTransaction(
      TransactionReqParams transactionReq, String method) async {
    return sl<TransactionApiService>().addTransaction(transactionReq, method);
  }
}
