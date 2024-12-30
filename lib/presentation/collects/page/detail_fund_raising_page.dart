import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailFundRaisingPage extends StatefulWidget {
  const DetailFundRaisingPage(
      {required this.collectID, required this.title, super.key});
  final String collectID;
  final String title;

  @override
  State<DetailFundRaisingPage> createState() => _DetailFundRaisingPageState();
}

class _DetailFundRaisingPageState extends State<DetailFundRaisingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                targetAmount(),
                const SizedBox(height: 10),
                collectButtons(),
                const SizedBox(height: 10),
                collectDesc(),
                const SizedBox(height: 15),
                collectProgress(),
                const SizedBox(height: 20),
                collectContributorsTitle(),
                const SizedBox(height: 15),
                collectContributors(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Padding collectProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: LinearPercentIndicator(
        width: 310,
        animation: true,
        lineHeight: 10,
        animationDuration: 1000,
        percent: 0.8,
        center: Text(
          "80.00%",
          style: TextStyle(fontSize: 8),
        ),
        barRadius: Radius.circular(4),
        backgroundColor: Color(0xFFFFAAAF),
        progressColor: Color(0xFF3FCB67),
      ),
    );
  }

  Padding collectDesc() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding collectContributorsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Liste des contributeurs.",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding collectContributors() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF03544F),
                child: Text(
                  getInitials('AMEDEKPEDZI Yao Mawunyo'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Righteous',
                  ),
                ),
              ),
              SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 248),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AMEDEKPEDZI Yao Mawunyo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "25 000 FCFA",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Icon tapped!');
                  // Add your desired functionality here
                },
                child: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Color(0xFF007F67),
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(color: Color(0xFFCCCCCC)),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF03544F),
                child: Text(
                  getInitials('AMEDEKPEDZI Yao Mawunyo'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Righteous',
                  ),
                ),
              ),
              SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 248),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AMEDEKPEDZI Yao Mawunyo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "25 000 FCFA",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Icon tapped!');
                  // Add your desired functionality here
                },
                child: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Color(0xFF007F67),
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(color: Color(0xFFCCCCCC)),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF03544F),
                child: Text(
                  getInitials('AMEDEKPEDZI Yao Mawunyo'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Righteous',
                  ),
                ),
              ),
              SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 248),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AMEDEKPEDZI Yao Mawunyo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "25 000 FCFA",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Icon tapped!');
                  // Add your desired functionality here
                },
                child: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Color(0xFF007F67),
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(color: Color(0xFFCCCCCC)),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF03544F),
                child: Text(
                  getInitials('AMEDEKPEDZI Yao Mawunyo'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: 'Righteous',
                  ),
                ),
              ),
              SizedBox(width: 10),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 248),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AMEDEKPEDZI Yao Mawunyo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "25 000 FCFA",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Icon tapped!');
                  // Add your desired functionality here
                },
                child: Icon(
                  Ionicons.chevron_forward_outline,
                  color: Color(0xFF007F67),
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(color: Color(0xFFCCCCCC)),
        ],
      ),
    );
  }

  Padding collectButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.add_outline,
                    size: 28,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Contributeurs",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.arrow_redo_outline,
                    size: 28,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Contribuer",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Icon(
                    Ionicons.open_outline,
                    size: 28,
                    color: Color(0xFF2FA9A2),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Mettre à jours",
                  style: TextStyle(
                    color: Color(0xFF2FA9A2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding targetAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Pending",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF4111F),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "150 000 FCFA",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          )),
    );
  }
}
