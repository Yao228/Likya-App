import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/login_req_params.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class LoginUseCase implements Usecase<Either, LoginReqParams> {
  @override
  Future<Either> call({LoginReqParams? param}) async {
    return sl<AuthRepository>().login(param!);
  }
}
