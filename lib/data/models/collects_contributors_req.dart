class CollectsContributorsReqParams {
  final List<dynamic> contributors;

  CollectsContributorsReqParams({
    required this.contributors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contributors': contributors,
    };
  }
}
