import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/transaction_req.dart';
import 'package:likya_app/domain/repository/transaction.dart';
import 'package:likya_app/service_locator.dart';

class AddTransactionParams {
  final TransactionReqParams transactionReqParams;
  final String methodParam;

  AddTransactionParams({
    required this.transactionReqParams,
    required this.methodParam,
  });
}

class AddTransactionUseCase implements Usecase<Either, AddTransactionParams> {
  @override
  Future<Either> call({AddTransactionParams? param}) async {
    if (param == null) {
      throw ArgumentError("param ne peut pas être null");
    }
    return sl<TransactionRepository>()
        .addTransaction(param.transactionReqParams, param.methodParam);
  }
}
