import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/add_collect_req.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class AddCollectUseCase implements Usecase<Either, AddCollectReqParams> {
  @override
  Future<Either> call({AddCollectReqParams? param}) async {
    return sl<CollectRepository>().addCollect(param!);
  }
}
