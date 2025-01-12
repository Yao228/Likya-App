import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/update_password_req.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class UpdatePasswordUseCase
    implements Usecase<Either, UpdatePasswordReqParams> {
  @override
  Future<Either> call({UpdatePasswordReqParams? param}) async {
    return sl<AuthRepository>().updatePassword(param!);
  }
}
