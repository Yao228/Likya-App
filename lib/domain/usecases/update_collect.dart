import 'package:dartz/dartz.dart';
import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/data/models/update_collect_req.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class UpdateCollectUseCase implements Usecase<Either, UpdateCollectReqParams> {
  @override
  Future<Either> call({UpdateCollectReqParams? param}) async {
    return sl<CollectRepository>().updateCollect(param!);
  }
}
