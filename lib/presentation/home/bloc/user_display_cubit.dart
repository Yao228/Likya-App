import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_user.dart';
import 'package:likya_app/presentation/home/bloc/user_display_state.dart';
import 'package:likya_app/service_locator.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await sl<GetUserUseCase>().call();
    result.fold((error) {
      emit(LoadUserFailure(errorMessage: error));
    }, (data) {
      emit(UserLoaded(userEntity: data));
    });
  }
}
