class CollectEntity {
  final String id;
  final String title;
  final int targetAmount;
  final String description;
  final Object categoryIds;
  final bool access;
  final String startDate;
  final String endDate;
  final Object contributors;
  final String status;
  final String linkId;
  final String collectId;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  CollectEntity({
    required this.id,
    required this.contributors,
    required this.status,
    required this.linkId,
    required this.collectId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.targetAmount,
    required this.description,
    required this.categoryIds,
    required this.access,
    required this.startDate,
    required this.endDate,
  });
}
