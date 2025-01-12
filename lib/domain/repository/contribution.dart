import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';

abstract class ContributionRepository {
  Future<Either> getContributions();
  Future<Either> addContribution(AddContributionReqParams contributionReq);
  Future<Either> getContribution();
}
