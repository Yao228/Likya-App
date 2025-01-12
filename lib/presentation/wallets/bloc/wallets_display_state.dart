abstract class WalletsDisplayState {}

class WalletsInitial extends WalletsDisplayState {}

class WalletsLoading extends WalletsDisplayState {}

class WalletsLoaded extends WalletsDisplayState {
  final List<dynamic> items;

  WalletsLoaded({required this.items});
}

class LoadWalletsFailure extends WalletsDisplayState {
  final String errorMessage;
  LoadWalletsFailure({required this.errorMessage});
}
