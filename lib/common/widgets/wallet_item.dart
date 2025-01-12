import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Widget walletItem(
  BuildContext context,
  String balance,
  String walletNumber,
  String currency,
  String status,
  bool isPriceHidden,
) {
  return Container(
    //bool isPriceHidden = false,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    width: 319,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blueAccent,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Solde',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    isPriceHidden ? '******' : balance,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    isPriceHidden ? '' : currency,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  /*setState(() {
                    isPriceHidden = !isPriceHidden;
                  });*/
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5),
                ),
                child: Icon(
                  isPriceHidden ? Ionicons.eye : Ionicons.eye_off,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'N° : $walletNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
