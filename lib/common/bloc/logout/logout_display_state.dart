abstract class LogoutState {}

class LogoutInitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutFailureState extends LogoutState {
  final String errorMessage;
  LogoutFailureState({required this.errorMessage});
}
