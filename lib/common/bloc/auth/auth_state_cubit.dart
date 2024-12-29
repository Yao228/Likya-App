import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/auth/auth_state.dart';
import 'package:likya_app/domain/usecases/is_logged_in.dart';
import 'package:likya_app/service_locator.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
