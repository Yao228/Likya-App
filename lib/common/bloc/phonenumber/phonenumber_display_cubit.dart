import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/common/bloc/phonenumber/phonenumber_display_state.dart';
import 'package:likya_app/domain/usecases/find_phonenumber.dart';
import 'package:likya_app/service_locator.dart';

class PhonenumberDisplayCubit extends Cubit<FindPhonenumberDisplayState> {
  PhonenumberDisplayCubit() : super(FindPhonenumberLoading());

  void displayFindPhonenumber() async {
    var result = await sl<FindPhonenumberUseCase>().call();
    result.fold((error) {
      emit(LoadFindPhonenumberFailure(errorMessage: error));
    }, (data) {
      emit(FindPhonenumberLoaded(findPhonenumberEntity: data));
    });
  }
}
