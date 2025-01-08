class ContributorsList {
  final String id;

  ContributorsList({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory ContributorsList.fromMap(Map<String, dynamic> map) {
    return ContributorsList(
      id: map['_id'] as String,
    );
  }
}
