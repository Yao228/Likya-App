import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/collect_req.dart';

abstract class CollectRepository {
  Future<Either> collect(CollectReqParams collectReq);
  Future<Either> getCollects();
  Future<Either> getCollect();
}
