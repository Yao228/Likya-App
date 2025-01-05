import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/add_collect_req.dart';
import 'package:likya_app/data/models/update_collect_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class CollectApiService {
  Future<Either> addCollect(AddCollectReqParams collectReq);
  Future<Either> updateCollect(UpdateCollectReqParams collectReq);
  Future<Either> getCollects();
  Future<Either> getCollect();
}

class CollectApiServiceImpl extends CollectApiService {
  @override
  Future<Either> addCollect(AddCollectReqParams collectReq) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var userID =
          await LocalStorageService.getString(LocalStorageService.userId);

      var response = await sl<DioClient>().post(ApiUrls.collects,
          queryParameters: {
            'user_id': userID,
          },
          data: collectReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> updateCollect(UpdateCollectReqParams collectReq) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var collectId =
          await LocalStorageService.getString(LocalStorageService.collectId);

      var response = await sl<DioClient>().put('${ApiUrls.collects}/$collectId',
          data: collectReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> getCollects() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var userID =
          await LocalStorageService.getString(LocalStorageService.userId);

      var response = await sl<DioClient>().get(
        ApiUrls.collects,
        queryParameters: {
          'created_by': userID,
          'sort': 'desc',
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> getCollect() async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var collectId =
          await LocalStorageService.getString(LocalStorageService.collectId);

      var response = await sl<DioClient>().get(
        '${ApiUrls.collects}/$collectId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }
}
