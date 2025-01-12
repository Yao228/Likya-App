import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_wallets.dart';
import 'package:likya_app/presentation/wallets/bloc/wallets_display_state.dart';
import 'package:likya_app/service_locator.dart';

class WalletsDisplayCubit extends Cubit<WalletsDisplayState> {
  WalletsDisplayCubit() : super(WalletsLoading());

  void displayWallets() async {
    var result = await sl<GetWalletsUseCase>().call();
    result.fold((error) {
      emit(LoadWalletsFailure(errorMessage: error));
    }, (data) {
      final items = data;
      emit(WalletsLoaded(items: items));
    });
  }
}
