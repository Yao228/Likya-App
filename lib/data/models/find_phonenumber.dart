import 'package:likya_app/domain/entities/find_phonenumber.dart';

class FindPhonenumberModel {
  final String id;
  String? fullname;
  final String phonenumber;
  String? avatar;

  FindPhonenumberModel({
    required this.id,
    required this.fullname,
    required this.phonenumber,
    required this.avatar,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'phonenumber': phonenumber,
      'avatar': avatar,
    };
  }

  factory FindPhonenumberModel.fromMap(Map<String, dynamic> map) {
    return FindPhonenumberModel(
      id: map['_id'] as String,
      fullname: map['fullname'] as String? ?? '',
      phonenumber: map['phonenumber'] as String,
      avatar: map['avatar'] as String? ?? '',
    );
  }
}

extension FindPhonenumberXModel on FindPhonenumberModel {
  FindPhonenumberEntity toEntity() {
    return FindPhonenumberEntity(
      id: id,
      fullname: fullname,
      phonenumber: phonenumber,
      avatar: avatar,
    );
  }
}
