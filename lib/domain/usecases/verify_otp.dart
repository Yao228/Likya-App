import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/verifyotp_req_params.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class VerifyOtpUseCase implements Usecase<Either, VerifyotpReqParams> {
  @override
  Future<Either> call({VerifyotpReqParams? param}) async {
    return sl<AuthRepository>().verifyOtp(param!);
  }
}
