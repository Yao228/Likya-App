class UpdateCollectReqParams {
  final String title;
  final int targetAmount;
  final String description;
  final List<String?> categoryIds;

  UpdateCollectReqParams({
    required this.title,
    required this.targetAmount,
    required this.description,
    required this.categoryIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'target_amount': targetAmount,
      'description': description,
      'category_ids': categoryIds,
    };
  }
}
