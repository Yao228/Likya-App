import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_contributors.dart';
import 'package:likya_app/presentation/contributors/bloc/contributions_display_state.dart';
import 'package:likya_app/service_locator.dart';

class ContributorsDisplayCubit extends Cubit<ContributorsDisplayState> {
  ContributorsDisplayCubit() : super(ContributorsLoading());

  void displayContributors(String collectId) async {
    var result = await sl<GetContributorsUseCase>().call(param: collectId);
    result.fold((error) {
      emit(LoadContributorsFailure(errorMessage: error));
    }, (data) {
      final items = data;
      emit(ContributorsLoaded(items: items));
    });
  }
}
