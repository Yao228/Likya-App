import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class GetCollectUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? param}) async {
    if (param == null || param.isEmpty) {
      return Left("Erreur de chargement");
    }
    return sl<CollectRepository>().getCollect(param);
  }
}
