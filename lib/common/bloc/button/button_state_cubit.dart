import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:likya_app/common/bloc/button/button_state.dart';
import 'package:likya_app/core/usecase/usecase.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void excute({dynamic params, required Usecase usecase}) async {
    emit(ButtonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }

  void performAutoLogin({dynamic params, required Usecase usecase}) async {
    emit(ButtonLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
