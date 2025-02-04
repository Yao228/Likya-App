import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/presentation/deposit/pages/add_deposit_page.dart';
import 'package:likya_app/presentation/transactions/pages/transaction_page.dart';

class GatewayPage extends StatefulWidget {
  const GatewayPage({super.key});

  @override
  State<GatewayPage> createState() => _GatewayPageState();
}

class _GatewayPageState extends State<GatewayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moyen d'ajout",
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                visaCi(),
                const SizedBox(height: 20),
                orangeCi(),
                const SizedBox(height: 20),
                mtnCi(),
                const SizedBox(height: 20),
                moovCi(),
                const SizedBox(height: 20),
                waveCi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding orangeCi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xE5D1D5DB),
            width: 1,
          ),
        ),
        height: 87,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDepositPage(gateway: 'orange-ci')),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Image.asset(
                "assets/images/orange-ci.png",
                //fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Orange Money',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '1,5% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 32,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding mtnCi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xE5D1D5DB),
            width: 1,
          ),
        ),
        height: 87,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDepositPage(gateway: 'mtn-ci')),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Image.asset(
                "assets/images/mtn-ci.png",
                //fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MTN MoMo',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '2% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 32,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding moovCi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xE5D1D5DB),
            width: 1,
          ),
        ),
        height: 87,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDepositPage(gateway: 'moov-ci')),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Image.asset(
                "assets/images/moov-ci.png",
                //fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Moov Money',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '2% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 32,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding waveCi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xE5D1D5DB),
            width: 1,
          ),
        ),
        height: 87,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDepositPage(gateway: 'wave-ci')),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Image.asset(
                "assets/images/wave-ci.png",
                //fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wave Mobile Money',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '1% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 32,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding visaCi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Color(0xE5D1D5DB),
            width: 1,
          ),
        ),
        height: 87,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddDepositPage(gateway: 'visa-ci')),
            );
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              Image.asset(
                "assets/images/visa-ci.png",
                //fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Visa/Mastercard',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '1% de frais opérateur.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 32,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
