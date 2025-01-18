abstract class TransactionsDisplayState {}

class TransactionsInitial extends TransactionsDisplayState {}

class TransactionsLoading extends TransactionsDisplayState {}

class TransactionsLoaded extends TransactionsDisplayState {
  final List<dynamic> items;

  TransactionsLoaded({required this.items});
}

class LoadTransactionsFailure extends TransactionsDisplayState {
  final String errorMessage;
  LoadTransactionsFailure({required this.errorMessage});
}
