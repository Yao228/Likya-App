import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/collects_contributors_req.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class AddCollectsContributorsUseCase
    implements Usecase<Either, CollectsContributorsReqParams> {
  @override
  Future<Either> call({CollectsContributorsReqParams? param}) async {
    return sl<CollectRepository>().addContributors(param!);
  }
}
