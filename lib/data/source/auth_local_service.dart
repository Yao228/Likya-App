import 'package:likya_app/utils/local_storage_service.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    var token = await LocalStorageService.getString(LocalStorageService.token);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
