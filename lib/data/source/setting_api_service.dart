import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/update_user_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class SettingApiService {
  Future<Either> updateProfil(UpdateUserReqParams updateUserReq);
}

class SettingApiServiceImpl extends SettingApiService {
  @override
  Future<Either> updateProfil(UpdateUserReqParams updateUserReq) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var userID =
          await LocalStorageService.getString(LocalStorageService.userId);

      var response = await sl<DioClient>().patch(
        '${ApiUrls.users}/$userID',
        data: updateUserReq.toMap(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
