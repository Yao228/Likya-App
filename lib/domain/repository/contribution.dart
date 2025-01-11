import 'package:dartz/dartz.dart';

abstract class ContributionRepository {
  Future<Either> getContributions();
}
