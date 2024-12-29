import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/password_req_params.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class PasswordRequestUseCase implements Usecase<Either, PasswordReqParams> {
  @override
  Future<Either> call({PasswordReqParams? param}) async {
    return sl<AuthRepository>().passwordRequest(param!);
  }
}
