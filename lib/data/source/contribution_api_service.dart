import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/core/constants/api_urls.dart';
import 'package:likya_app/core/network/doi_client.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

abstract class ContributionApiService {
  Future<Either> getContributions(String collectId);
  Future<Either> addContribution(AddContributionReqParams contributionReq, String collectId);
  Future<Either> getContribution(String contributionId);
}

class ContributionApiServiceImpl extends ContributionApiService {
  @override
  Future<Either> addContribution(
      AddContributionReqParams contributionReq, String collectId) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().post(ApiUrls.contributes,
          queryParameters: {
            'collect_id': collectId,
          },
          data: contributionReq.toMap(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message_error']);
    }
  }

  @override
  Future<Either> getContribution(String contributionId) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);

      var response = await sl<DioClient>().get(
        '${ApiUrls.contributes}/$contributionId',
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
  Future<Either> getContributions(String collectId) async {
    try {
      var token =
          await LocalStorageService.getString(LocalStorageService.token);
      var response = await sl<DioClient>().get(
        ApiUrls.contributes,
        queryParameters: {
          'collect_id': collectId,
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
}
