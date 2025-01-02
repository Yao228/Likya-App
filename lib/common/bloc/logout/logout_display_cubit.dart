import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:likya_app/common/bloc/logout/logout_display_state.dart';
import 'package:likya_app/core/usecase/usecase.dart';

class LogoutStateCubit extends Cubit<LogoutState> {
  LogoutStateCubit() : super(LogoutInitialState());

  void excute({required Usecase usecase}) async {
    emit(LogoutLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call();
      result.fold((error) {
        emit(LogoutFailureState(errorMessage: error));
      }, (data) {
        emit(LogoutSuccessState());
      });
    } catch (e) {
      emit(LogoutFailureState(errorMessage: e.toString()));
    }
  }
}
