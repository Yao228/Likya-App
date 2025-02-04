import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/deposit_req.dart';
import 'package:likya_app/domain/repository/deposit.dart';
import 'package:likya_app/service_locator.dart';

class AddDepositParams {
  final DepositReqParams depositReqParams;
  final String depositParam;

  AddDepositParams({
    required this.depositReqParams,
    required this.depositParam,
  });
}

class AddDepositUseCase implements Usecase<Either, AddDepositParams> {
  @override
  Future<Either> call({AddDepositParams? param}) async {
    if (param == null) {
      throw ArgumentError("param ne peut pas être null");
    }
    return sl<DepositRepository>()
        .addDeposit(param.depositReqParams, param.depositParam);
  }
}
