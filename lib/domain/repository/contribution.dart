import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/add_contribution_req.dart';

abstract class ContributionRepository {
  Future<Either> getContributions(String collectId);
  Future<Either> addContribution(AddContributionReqParams contributionReq, String collectId);
  Future<Either> getContribution(String contributionId);
}
