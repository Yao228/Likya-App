import 'package:flutter/material.dart';

class TransactionDetail extends StatefulWidget {
  final String transactionId;
  final String description;

  const TransactionDetail(
      {required this.transactionId, required this.description, super.key});

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails ${widget.description}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            child: Center(child: Text("Détails de la transaction")),
          ),
        ),
      ),
    );
  }
}
