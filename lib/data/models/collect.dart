import 'package:likya_app/domain/entities/collect.dart';

class CollectModel {
  final String id;
  final Map<String, dynamic> userDict; // Changed type here
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

  CollectModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_dict': userDict,
      'title': title,
      'description': description,
      'targetAmount': targetAmount,
      'categories': categories,
      'access': access,
      'startDate': startDate,
      'endDate': endDate,
      'collectId': collectId,
      'linkId': linkId,
      'contributors': contributors,
      'status': status,
    };
  }

  factory CollectModel.fromMap(Map<String, dynamic> map) {
    return CollectModel(
      id: map['_id'] as String,
      userDict: (map['user_dict'] as Map<String, dynamic>? ?? {}),
      title: map['title'] as String,
      description: map['description'] as String,
      targetAmount: map['target_amount'] as double,
      categories: map['category_ids'] as List<dynamic>? ?? [],
      access: map['access'] as bool,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
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
      userDict: userDict,
      contributors: contributors,
      status: status,
      linkId: linkId,
      collectId: collectId,
      title: title,
      targetAmount: targetAmount,
      description: description,
      categories: categories,
      access: access,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
