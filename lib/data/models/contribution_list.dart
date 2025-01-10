class ContributionList {
  final String id;
  final double amount;
  final bool keepAnonymous;
  final String collectId;
  final String contributor;
  final String addressIp;
  final String addressMac;
  final String status;
  final String comment;
  final String contributedAt;
  final String createdAt;
  final String updatedAt;

  ContributionList({
    required this.id,
    required this.amount,
    required this.keepAnonymous,
    required this.collectId,
    required this.contributor,
    required this.addressIp,
    required this.addressMac,
    required this.status,
    required this.comment,
    required this.contributedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'keepAnonymous': keepAnonymous,
      'collectId': collectId,
      'contributor': contributor,
      'addressIp': addressIp,
      'addressMac': addressMac,
      'status': status,
      'comment': comment,
      'contributedAt': contributedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ContributionList.fromMap(Map<String, dynamic> map) {
    return ContributionList(
      id: map['_id'] as String,
      amount: map['amount'] as double,
      keepAnonymous: map['keep_anonymous'] as bool,
      collectId: map['collect_id'] as String,
      contributor: map['contributor'] as String,
      addressIp: map['address_ip'] as String,
      addressMac: map['address_mac'] as String,
      status: map['status'] as String,
      comment: map['comment'] as String,
      contributedAt: map['contributed_at'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }
}
