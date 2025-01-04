class UpdateUserReqParams {
  final String fullname;
  final Object attributes;

  UpdateUserReqParams({
    required this.fullname,
    required this.attributes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'attributes': attributes,
    };
  }
}
