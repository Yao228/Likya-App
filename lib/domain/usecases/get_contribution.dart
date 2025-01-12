import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/source/contribution_api_service.dart';
import 'package:likya_app/service_locator.dart';

class GetContributionUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<ContributionApiService>().getContribution();
  }
}
