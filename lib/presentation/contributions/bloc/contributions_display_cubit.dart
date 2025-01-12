import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/presentation/contributions/bloc/contributions_display_state.dart';
import 'package:likya_app/service_locator.dart';

import '../../../domain/usecases/get_contributions.dart';

class ContributionsDisplayCubit extends Cubit<ContributionsDisplayState> {
  ContributionsDisplayCubit() : super(ContributionsLoading());

  void displayContributions() async {
    var result = await sl<GetContributionsUseCase>().call();
    result.fold((error) {
      emit(LoadContributionsFailure(errorMessage: error));
    }, (data) {
      final items = data;
      emit(ContributionsLoaded(items: items));
    });
  }
}
