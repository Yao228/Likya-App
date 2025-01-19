class ContributorsList {
  final List<String> items;

  ContributorsList({
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items,
    };
  }

  factory ContributorsList.fromMap(Map<String, dynamic> map) {
    return ContributorsList(
      items: List<String>.from(map['items'] ?? []),
    );
  }
}
