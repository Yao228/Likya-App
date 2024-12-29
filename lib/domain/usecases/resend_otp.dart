import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/resendotp_req_params.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class ResendOtpUsecase implements Usecase<Either, ResendotpReqParams> {
  @override
  Future<Either> call({ResendotpReqParams? param}) async {
    return sl<AuthRepository>().resendOtp(param!);
  }
}
