import 'package:flutter/material.dart';

class DetailsContributors extends StatefulWidget {
  const DetailsContributors({
    required this.contributionId,
    required this.contributorName,
    super.key,
  });

  final String contributorName;
  final String contributionId;

  @override
  State<DetailsContributors> createState() => _DetailsContributorsState();
}

class _DetailsContributorsState extends State<DetailsContributors> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
