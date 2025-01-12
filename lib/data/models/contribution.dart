import 'package:likya_app/domain/entities/contribution.dart';

class ContributionModel {
  final String id;
  final String collectId;
  final String contributor;
  final double amount;
  final bool keepAnonymous;
  final String comment;
  final String contributedAt;

  ContributionModel({
    required this.id,
    required this.collectId,
    required this.contributor,
    required this.amount,
    required this.keepAnonymous,
    required this.comment,
    required this.contributedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'keepAnonymous': keepAnonymous,
      'collectId': collectId,
      'contributor': contributor,
      'comment': comment,
      'contributedAt': contributedAt,
    };
  }

  factory ContributionModel.fromMap(Map<String, dynamic> map) {
    return ContributionModel(
      id: map['_id'] as String,
      amount: map['amount'] as double,
      keepAnonymous: map['keep_anonymous'] as bool,
      collectId: map['collect_id'] as String,
      contributor: map['contributor'] as String,
      comment: map['comment'] as String,
      contributedAt: map['contributed_at'] as String,
    );
  }
}

extension CollectXModel on ContributionModel {
  ContributionEntity toEntity() {
    return ContributionEntity(
      id: id,
      collectId: collectId,
      contributor: contributor,
      amount: amount,
      keepAnonymous: keepAnonymous,
      comment: comment,
      contributedAt: contributedAt,
    );
  }
}
