abstract class CollectsDisplayState {}

class CollectsInitial extends CollectsDisplayState {}

class CollectsLoading extends CollectsDisplayState {}

class CollectsLoaded extends CollectsDisplayState {
  final List<dynamic> items;

  CollectsLoaded({required this.items});
}

class LoadCollectsFailure extends CollectsDisplayState {
  final String errorMessage;
  LoadCollectsFailure({required this.errorMessage});
}
