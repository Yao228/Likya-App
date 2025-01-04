import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/update_user_req.dart';
import 'package:likya_app/data/models/user.dart';
import 'package:likya_app/data/source/setting_api_service.dart';
import 'package:likya_app/domain/repository/setting.dart';
import 'package:likya_app/service_locator.dart';

class SettingRepositoryImpl extends SettingRepository {
  @override
  Future<Either> updateProfil(UpdateUserReqParams updateUserReq) async {
    Either result = await sl<SettingApiService>().updateProfil(updateUserReq);
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      var userModel = UserModel.fromMap(response.data);
      var userEntity = userModel.toEntity();
      return Right(userEntity);
    });
  }
}
