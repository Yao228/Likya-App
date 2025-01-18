import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/transaction_req.dart';

abstract class TransactionRepository {
  Future<Either> addTransaction(
      TransactionReqParams transactionReq, String method);
  Future<Either> getTransactions();
}
