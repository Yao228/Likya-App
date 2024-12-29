import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/password_reset.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class PasswordResetUseCase implements Usecase<Either, PasswordResetParams> {
  @override
  Future<Either> call({PasswordResetParams? param}) async {
    return sl<AuthRepository>().passwordReset(param!);
  }
}
