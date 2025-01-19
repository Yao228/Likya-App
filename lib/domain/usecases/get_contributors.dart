import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class GetContributorsUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? param}) async {
    return sl<CollectRepository>().getContributors(param!);
  }
}
