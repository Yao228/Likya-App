import 'package:flutter/material.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';

class SuccessDepositPage extends StatefulWidget {
  final double totalAmount;

  const SuccessDepositPage({required this.totalAmount, super.key});

  @override
  State<SuccessDepositPage> createState() => _SuccessDepositState();
}

class _SuccessDepositState extends State<SuccessDepositPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recharge effectuée',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              receipt(),
              const SizedBox(height: 20),
              message(),
              const SizedBox(height: 100),
              submit(),
            ],
          ),
        )),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding receipt() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Image.asset("assets/images/receipt2.png"),
    );
  }

  Padding message() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "Votre compte à été  rechargé de ${widget.totalAmount.toString()} FCFA ",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding submit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Terminé!',
            onPressed: () async {},
          );
        },
      ),
    );
  }
}
