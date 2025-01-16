import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_contribution.dart';
import 'package:likya_app/presentation/contributions/bloc/contribution_display_state.dart';
import 'package:likya_app/service_locator.dart';

class ContributionDisplayCubit extends Cubit<ContributionDisplayState> {
  ContributionDisplayCubit() : super(ContributionLoading());

  void displayContribution(String contributionId) async {
    var result = await sl<GetContributionUseCase>().call(param: contributionId);
    result.fold((error) {
      emit(LoadContributionFailure(errorMessage: error));
    }, (data) {
      emit(ContributionLoaded(contributiontEntity: data));
    });
  }
}
