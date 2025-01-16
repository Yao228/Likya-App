import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/source/contribution_api_service.dart';
import 'package:likya_app/service_locator.dart';

class GetContributionUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? param}) async {
    if (param == null || param.isEmpty) {
      return Left("Erreur de chargement");
    }
    return sl<ContributionApiService>().getContribution(param);
  }
}
