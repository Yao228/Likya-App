import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/transaction_list.dart';
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

  @override
  Future<Either> getTransactions() async {
    Either result = await sl<TransactionApiService>().getTransactions();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var transactionLists = (response.data["items"] as List)
            .map(
                (item) => TransactionList.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(transactionLists);
      },
    );
  }
}
