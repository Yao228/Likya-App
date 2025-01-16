import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_collect.dart';
import 'package:likya_app/presentation/collects/bloc/collect_display_state.dart';
import 'package:likya_app/service_locator.dart';

class CollectDisplayCubit extends Cubit<CollectDisplayState> {
  CollectDisplayCubit() : super(CollectLoading());

  void displayCollect(String collectId) async {
    var result = await sl<GetCollectUseCase>().call(param: collectId);
    result.fold((error) {
      emit(LoadCollectFailure(errorMessage: error));
    }, (data) {
      emit(CollectLoaded(collectEntity: data));
    });
  }
}
