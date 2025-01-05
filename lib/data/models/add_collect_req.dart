class AddCollectReqParams {
  final String title;
  final int targetAmount;
  final String description;
  final List<String?> categoryIds;
  final bool access;
  final String startDate;
  final String endDate;

  AddCollectReqParams({
    required this.title,
    required this.targetAmount,
    required this.description,
    required this.categoryIds,
    required this.access,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'target_amount': targetAmount,
      'description': description,
      'category_ids': categoryIds,
      'access': access,
      'start_date': startDate,
      'end_date': endDate
    };
  }
}
