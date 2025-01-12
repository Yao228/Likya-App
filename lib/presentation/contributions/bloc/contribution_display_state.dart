import 'package:likya_app/domain/entities/contribution.dart';

abstract class ContributionDisplayState {}

class ContributionLoading extends ContributionDisplayState {}

class ContributionLoaded extends ContributionDisplayState {
  final ContributionEntity contributiontEntity;
  ContributionLoaded({required this.contributiontEntity});
}

class LoadContributionFailure extends ContributionDisplayState {
  final String errorMessage;
  LoadContributionFailure({required this.errorMessage});
}
