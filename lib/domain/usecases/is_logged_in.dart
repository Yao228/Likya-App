import 'package:likya_app/core/usecase/usecase.dart';
import 'package:likya_app/domain/repository/auth.dart';
import 'package:likya_app/service_locator.dart';

class IsLoggedInUseCase implements Usecase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
