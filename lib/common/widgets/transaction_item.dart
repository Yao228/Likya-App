import 'package:flutter/material.dart';

Widget transactionItem(
    IconData iconName, String title, String date, String amount) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(3),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF2FA9A2),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Icon(
                  iconName,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                date,
                style: TextStyle(
                  color: Color(0xFFADB3BC),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
      const SizedBox(width: 30),
      Text(
        amount,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.end,
      ),
    ],
  );
}
