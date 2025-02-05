import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:likya_app/common/widgets/button/basic_app_button.dart';
import 'package:likya_app/utils/local_storage_service.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDepositPage extends StatefulWidget {
  final String gateway;
  final double percent;
  final int amount;
  final double charge;
  final double totalAmount;

  const DetailDepositPage({
    required this.gateway,
    required this.percent,
    required this.amount,
    required this.charge,
    required this.totalAmount,
    super.key,
  });

  @override
  State<DetailDepositPage> createState() => _DetailDepositPageState();
}

class _DetailDepositPageState extends State<DetailDepositPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détail de la recharge',
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
              amountDeposit(),
              const SizedBox(height: 10),
              chargeDeposit(),
              const SizedBox(height: 10),
              totalDeposit(),
              const SizedBox(height: 10),
              line(),
              const SizedBox(height: 10),
              paymentMethod(),
              const SizedBox(height: 50),
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
      child: Image.asset("assets/images/receipt.png"),
    );
  }

  Padding chargeDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Frais',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "+${NumberFormat.currency(locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0).format(widget.charge)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding amountDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Montant',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            NumberFormat.currency(
                    locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0)
                .format(widget.totalAmount),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding totalDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Totalà payer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "${widget.totalAmount.toString()} FCFA",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding line() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 10,
        endIndent: 10,
      ),
    );
  }

  Padding paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Moyen de payement',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gatewayName(widget.gateway),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.percent}% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xE5D1D5DB),
                    width: 1,
                  ),
                ),
                child: Image.asset("assets/images/${widget.gateway}.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding submit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Builder(
        builder: (context) {
          return BasicAppButton(
            title: 'Procéder à la recharge',
            onPressed: () async {
              String? paymentUrl = await LocalStorageService.getString(
                  LocalStorageService.payementUrl);
              if (paymentUrl != null &&
                  await canLaunchUrl(Uri.parse(paymentUrl))) {
                await launchUrl(Uri.parse(paymentUrl),
                    mode: LaunchMode.externalApplication);
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Erreur : L'URL de paiement est invalide."),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
