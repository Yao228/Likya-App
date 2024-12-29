import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:likya_app/data/models/collect.dart';
import 'package:likya_app/data/models/collect_req.dart';
import 'package:likya_app/data/source/collect_api_service.dart';
import 'package:likya_app/domain/repository/collect.dart';
import 'package:likya_app/service_locator.dart';

class CollectRepositoryImpl extends CollectRepository {
  @override
  Future<Either> collect(CollectReqParams collectReq) async {
    return sl<CollectApiService>().collect(collectReq);
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
        var collectModels = (response.data["items"] as List)
            .map((item) => CollectModel.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(collectModels);
      },
    );
  }
}
