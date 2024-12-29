import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/signup_req_params.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class SignupUseCase implements Usecase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
