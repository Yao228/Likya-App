import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/add_collect_req.dart';
import 'package:likya_app/data/models/collects_contributors_req.dart';
import 'package:likya_app/data/models/update_collect_req.dart';

abstract class CollectRepository {
  Future<Either> addCollect(AddCollectReqParams collectReq);
  Future<Either> updateCollect(UpdateCollectReqParams collectReq);
  Future<Either> getCollects();
  Future<Either> getCollect(String collectId);
  Future<Either> addContributors(CollectsContributorsReqParams contributorsReq);
  Future<Either> getContributors(String collectId);
  Future<Either> collectAccess(bool access);
}
