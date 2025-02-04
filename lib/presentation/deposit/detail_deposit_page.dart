import 'package:flutter/material.dart';

class DetailDepositPage extends StatefulWidget {
  const DetailDepositPage({super.key});

  @override
  State<DetailDepositPage> createState() => _DetailDepositPageState();
}

class _DetailDepositPageState extends State<DetailDepositPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détail du dépôt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        )),
      ),
      backgroundColor: Colors.white,
    );
  }
}
