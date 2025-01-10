import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/contribution.dart';
import 'package:likya_app/service_locator.dart';

class GetContributionsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<ContributionRepository>().getContributions(param);
  }
}
