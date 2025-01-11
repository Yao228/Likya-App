abstract class ContributionsDisplayState {}

class ContributionsInitial extends ContributionsDisplayState {}

class ContributionsLoading extends ContributionsDisplayState {}

class ContributionsLoaded extends ContributionsDisplayState {
  final List<dynamic> items;

  ContributionsLoaded({required this.items});
}

class LoadContributionsFailure extends ContributionsDisplayState {
  final String errorMessage;
  LoadContributionsFailure({required this.errorMessage});
}
