class ContributionEntity {
  final String id;
  final String collectId;
  final String contributor;
  final double amount;
  final bool keepAnonymous;
  final String comment;
  final String contributedAt;

  ContributionEntity({
    required this.id,
    required this.collectId,
    required this.contributor,
    required this.amount,
    required this.keepAnonymous,
    required this.comment,
    required this.contributedAt,
  });
}
