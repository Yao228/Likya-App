import 'package:flutter/widgets.dart';

class TransactionPage extends StatefulWidget {
  final String method;
  const TransactionPage({ required this.method, super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
