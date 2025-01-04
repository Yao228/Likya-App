class CollectEntity {
  final String id;
  final Map<String, dynamic> userDict;
  final String title;
  final double targetAmount;
  final String description;
  final List<dynamic> categories;
  final bool access;
  final String startDate;
  final String endDate;
  final List<dynamic> contributors;
  final String status;
  final String linkId;
  final String collectId;

  CollectEntity({
    required this.id,
    required this.userDict,
    required this.contributors,
    required this.status,
    required this.linkId,
    required this.collectId,
    required this.title,
    required this.targetAmount,
    required this.description,
    required this.categories,
    required this.access,
    required this.startDate,
    required this.endDate,
  });
}
