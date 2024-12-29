import 'package:flutter/material.dart';

class DetailFundRaisingPage extends StatefulWidget {
  final dynamic collectId;

  const DetailFundRaisingPage(this.collectId, {super.key});

  @override
  State<DetailFundRaisingPage> createState() => _DetailFundRaisingPageState();
}

class _DetailFundRaisingPageState extends State<DetailFundRaisingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Détails",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
