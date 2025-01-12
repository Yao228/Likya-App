import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/service_locator.dart';

class AddContributionUseCase
    implements Usecase<Either, AddContributionReqParams> {
  @override
  Future<Either> call({AddContributionReqParams? param}) async {
    return sl<ContributionRepository>().addContribution(param!);
  }
}
