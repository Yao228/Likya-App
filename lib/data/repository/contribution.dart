import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';
import 'package:likya_app/data/models/contribution.dart';
import 'package:likya_app/data/models/contribution_list.dart';
import 'package:likya_app/data/source/contribution_api_service.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/service_locator.dart';

class ContributionRepositoryImpl extends ContributionRepository {
  @override
  Future<Either> addContribution(
      AddContributionReqParams contributionReq) async {
    return sl<ContributionApiService>().addContribution(contributionReq);
  }

  @override
  Future<Either> getContribution(String contributionId) async {
    Either result = await sl<ContributionApiService>().getContribution(contributionId);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var contributionModel = ContributionModel.fromMap(response.data);
        var contributionEntity = contributionModel.toEntity();
        return Right(contributionEntity);
      },
    );
  }

  @override
  Future<Either> getContributions() async {
    Either result = await sl<ContributionApiService>().getContributions();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var contributionLists = (response.data["items"] as List)
            .map((item) =>
                ContributionList.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(contributionLists);
      },
    );
  }
}
