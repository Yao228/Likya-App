import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_collects.dart';
import 'package:likya_app/presentation/collects/bloc/collects_display_state.dart';
import 'package:likya_app/service_locator.dart';

class CollectsDisplayCubit extends Cubit<CollectsDisplayState> {
  CollectsDisplayCubit() : super(CollectsLoading());

  void displayCollects() async {
    var result = await sl<GetCollectsUseCase>().call();
    result.fold((error) {
      emit(LoadCollectsFailure(errorMessage: error));
    }, (data) {
      final items = data;
      emit(CollectsLoaded(items: items));
    });
  }
}
