import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/contribution_list.dart';
import 'package:likya_app/data/source/api_contribution_service.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/service_locator.dart';

class ContributionRepositoryImpl extends ContributionRepository {
  @override
  Future<Either> getContributions() async {
    Either result = await sl<ContributionApiServiceImpl>().getContributions();
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
