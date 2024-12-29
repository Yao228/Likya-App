import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:likya_app/common/bloc/resend/text_state.dart';
import 'package:likya_app/core/usecase/usecase.dart';

class TextStateCubit extends Cubit<TextState> {
  TextStateCubit() : super(TextInitialState());

  void excute({dynamic params, required Usecase usecase}) async {
    emit(TextLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(TextFailureState(errorMessage: error));
      }, (data) {
        emit(TextSuccessState());
      });
    } catch (e) {
      emit(TextFailureState(errorMessage: e.toString()));
    }
  }

  void performAutoLogin({dynamic params, required Usecase usecase}) async {
    emit(TextLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(TextFailureState(errorMessage: error));
      }, (data) {
        emit(TextSuccessState());
      });
    } catch (e) {
      emit(TextFailureState(errorMessage: e.toString()));
    }
  }
}
