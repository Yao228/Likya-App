import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/collect.dart';
import 'package:likya_app/data/models/collect_list.dart';
import 'package:likya_app/data/models/add_collect_req.dart';
import 'package:likya_app/data/models/update_collect_req.dart';
import 'package:likya_app/data/source/collect_api_service.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class CollectRepositoryImpl extends CollectRepository {
  @override
  Future<Either> addCollect(AddCollectReqParams collectReq) async {
    return sl<CollectApiService>().addCollect(collectReq);
  }

  @override
  Future<Either> updateCollect(UpdateCollectReqParams collectReq) async {
    return sl<CollectApiService>().updateCollect(collectReq);
  }

  @override
  Future<Either> getCollects() async {
    Either result = await sl<CollectApiService>().getCollects();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var collectLists = (response.data["items"] as List)
            .map((item) => CollectList.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(collectLists);
      },
    );
  }

  @override
  Future<Either> getCollect() async {
    Either result = await sl<CollectApiService>().getCollect();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;
        var collectModel = CollectModel.fromMap(response.data);
        var collectEntity = collectModel.toEntity();
        return Right(collectEntity);
      },
    );
  }
}
