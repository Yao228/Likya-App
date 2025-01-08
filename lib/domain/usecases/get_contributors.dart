import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class GetContributorsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<CollectRepository>().getContributors();
  }
}
