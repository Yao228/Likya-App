import 'package:likya_app/domain/entities/collect.dart';

abstract class CollectDisplayState {}

class CollectLoading extends CollectDisplayState {}

class CollectLoaded extends CollectDisplayState {
  final CollectEntity collectEntity;
  CollectLoaded({required this.collectEntity});
}

class LoadCollectFailure extends CollectDisplayState {
  final String errorMessage;
  LoadCollectFailure({required this.errorMessage});
}
