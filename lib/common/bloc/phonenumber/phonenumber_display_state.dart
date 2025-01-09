import 'package:likya_app/domain/entities/find_phonenumber.dart';

abstract class FindPhonenumberDisplayState {}

class FindPhonenumberLoading extends FindPhonenumberDisplayState {}

class FindPhonenumberLoaded extends FindPhonenumberDisplayState {
  final FindPhonenumberEntity findPhonenumberEntity;
  FindPhonenumberLoaded({required this.findPhonenumberEntity});
}

class LoadFindPhonenumberFailure extends FindPhonenumberDisplayState {
  final String errorMessage;
  LoadFindPhonenumberFailure({required this.errorMessage});
}
