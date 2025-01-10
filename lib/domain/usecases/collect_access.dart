import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class CollectAccessUseCase implements Usecase<Either, bool> {
  @override
  Future<Either> call({bool param = false}) async {
    return await sl<CollectRepository>().collectAccess(param);
  }
}
