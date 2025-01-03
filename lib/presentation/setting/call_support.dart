import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ionicons/ionicons.dart';

class CallSupport extends StatefulWidget {
  const CallSupport({super.key});

  @override
  State<CallSupport> createState() => _CallSupportState();
}

class _CallSupportState extends State<CallSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support',
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                supportImage(),
                supportTitle(),
                SizedBox(height: 15),
                supportDesc(),
                SizedBox(height: 100),
                supportCall(),
                SizedBox(height: 15),
                supportWhatsapp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding supportTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Bonjour, Comment pouvons-nous vous aider ?',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding supportDesc() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Bienvenue sur notre page de support client ! Notre mission est de vous offrir une assistance rapide, efficace et personnalisée.',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding supportCall() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0x26D1D5DB),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onPressed: () async {
            FlutterPhoneDirectCaller.callNumber('002250777214886');
            //launch('tel:002250777214886');
          },
          icon: const Icon(
            Ionicons.call_outline,
            size: 28,
            color: Colors.black,
          ),
          label: const Text(
            'Contact via téléphone',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Padding supportWhatsapp() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0x26D1D5DB),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Ionicons.logo_whatsapp,
            size: 28,
            color: Colors.green,
          ),
          label: const Text(
            'Contact via whatsapp',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Padding supportImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 20),
      child: Image.asset("assets/images/support.png"),
    );
  }
}
