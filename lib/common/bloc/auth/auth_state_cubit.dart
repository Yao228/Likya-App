import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/auth/auth_state.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/domain/usecases/is_logged_in.dart';
import 'package:likya_app/service_locator.dart';
import 'package:likya_app/utils/local_storage_service.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    bool isValideToken = await ApiService().checkValidateAccessToken();
    if (isLoggedIn && isValideToken) {
      emit(Authenticated());
    } else {
      LocalStorageService.deleteKey(LocalStorageService.token);
      emit(UnAuthenticated());
    }
  }
}
