class AddContributionReqParams {
  final int amount;
  final String comment;
  final bool keepAnonymous;

  AddContributionReqParams({
    required this.amount,
    required this.comment,
    required this.keepAnonymous,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'comment': comment,
      'keep_anonymous': keepAnonymous,
    };
  }
}
