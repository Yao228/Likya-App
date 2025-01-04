import 'package:dartz/dartz.dart';
import 'package:likya_app/data/models/update_user_req.dart';

abstract class SettingRepository {
  Future<Either> updateProfil(UpdateUserReqParams updateUserReq);
}
