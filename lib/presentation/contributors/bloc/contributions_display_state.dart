abstract class ContributorsDisplayState {}

class ContributorsInitial extends ContributorsDisplayState {}

class ContributorsLoading extends ContributorsDisplayState {}

class ContributorsLoaded extends ContributorsDisplayState {
  final List<dynamic> items;

  ContributorsLoaded({required this.items});
}

class LoadContributorsFailure extends ContributorsDisplayState {
  final String errorMessage;
  LoadContributorsFailure({required this.errorMessage});
}
