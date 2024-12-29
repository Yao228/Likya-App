import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/collect_req.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class CollectUseCase implements Usecase<Either, CollectReqParams> {
  @override
  Future<Either> call({CollectReqParams? param}) async {
    return sl<CollectRepository>().collect(param!);
  }
}
