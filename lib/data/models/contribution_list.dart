class ContributionList {
  final String id;
  final double amount;
  final bool keepAnonymous;
  final String collectId;
  final String contributor;
  final String status;
  final String comment;
  final String contributedAt;

  ContributionList({
    required this.id,
    required this.amount,
    required this.keepAnonymous,
    required this.collectId,
    required this.contributor,
    required this.status,
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
      'status': status,
      'comment': comment,
      'contributedAt': contributedAt,
    };
  }

  factory ContributionList.fromMap(Map<String, dynamic> map) {
    return ContributionList(
      id: map['_id'] as String,
      amount: map['amount'] as double,
      keepAnonymous: map['keep_anonymous'] as bool,
      collectId: map['collect_id'] as String,
      contributor: map['contributor'] as String,
      status: map['status'] as String,
      comment: map['comment'] as String,
      contributedAt: map['contributed_at'] as String,
    );
  }
}
