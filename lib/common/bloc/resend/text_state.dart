abstract class TextState {}

class TextInitialState extends TextState {}

class TextLoadingState extends TextState {}

class TextSuccessState extends TextState {}

class TextFailureState extends TextState {
  final String errorMessage;
  TextFailureState({required this.errorMessage});
}
