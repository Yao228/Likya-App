import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/service_locator.dart';


class AddContributionParams {
  final AddContributionReqParams contributionReq;
  final String collectId;

  AddContributionParams({
    required this.contributionReq,
    required this.collectId,
  });
}

class AddContributionUseCase
    implements Usecase<Either, AddContributionParams> {
  @override
  Future<Either> call({AddContributionParams? param}) async {
    if (param == null) {
      throw ArgumentError("param ne peut pas être null");
    }
    return sl<ContributionRepository>().addContribution(param.contributionReq, param.collectId);
  }
}
