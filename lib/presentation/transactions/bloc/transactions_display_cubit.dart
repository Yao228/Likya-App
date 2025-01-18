import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:likya_app/domain/usecases/get_transactions.dart';
import 'package:likya_app/presentation/transactions/bloc/transactions_display_state.dart';
import 'package:likya_app/service_locator.dart';

class TransactionsDisplayCubit extends Cubit<TransactionsDisplayState> {
  TransactionsDisplayCubit() : super(TransactionsLoading());

  void displayTransactions() async {
    var result = await sl<GetTransactionsUseCase>().call();
    if (isClosed) return;

    result.fold(
      (error) {
        if (!isClosed) emit(LoadTransactionsFailure(errorMessage: error));
      },
      (data) {
        if (!isClosed) emit(TransactionsLoaded(items: data));
      },
    );
  }
}
