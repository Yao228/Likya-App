import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/update_user_req.dart';
import 'package:likya_app/domain/repository/setting.dart';
import 'package:likya_app/service_locator.dart';

class UpdateUserUseCase implements Usecase<Either, UpdateUserReqParams> {
  @override
  Future<Either> call({UpdateUserReqParams? param}) async {
    return sl<SettingRepository>().updateProfil(param!);
  }
}
