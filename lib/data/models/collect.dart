import 'package:likya_app/domain/entities/collect.dart';

class CollectModel {
  final String id;
  final String title;
  final double targetAmount;
  final String description;
  final List<dynamic> categoryIds;
  final bool access;
  final String startDate;
  final String endDate;
  final List<dynamic> contributors;
  final String status;
  final String linkId;
  final String collectId;
  final List<dynamic> createdBy;
  final String createdAt;
  final String updatedAt;

  CollectModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'categoryIds': categoryIds,
      'access': access,
      'startDate': startDate,
      'endDate': endDate,
      'createdBy': createdBy,
      'collectId': collectId,
      'linkId': linkId,
      'contributors': contributors,
      'status': status
    };
  }

  factory CollectModel.fromMap(Map<String, dynamic> map) {
    return CollectModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      targetAmount: map['target_amount'] as double,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      categoryIds: map['category_ids'] as List<dynamic>? ?? [],
      access: map['access'] as bool,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
      createdBy: map['created_by'] as List<dynamic>? ?? [],
      collectId: map['collect_id'] as String,
      linkId: map['link_id'] as String,
      contributors: map['contributors'] as List<dynamic>? ?? [],
      status: map['status'] as String,
    );
  }
}

extension CollectXModel on CollectModel {
  CollectEntity toEntity() {
    return CollectEntity(
      id: id,
      contributors: contributors,
      status: status,
      linkId: linkId,
      collectId: collectId,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      targetAmount: targetAmount,
      description: description,
      categoryIds: categoryIds,
      access: access,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
