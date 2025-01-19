import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:likya_app/presentation/collects/page/detail_fund_raising_page.dart';
import 'package:likya_app/utils/utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget collectItem(
  String collectID,
  BuildContext context,
  IconData iconName,
  String title,
  String description,
  String targetAmount,
  String startDate,
  String endDate,
  String status,
  double? percent,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    decoration: BoxDecoration(
      color: Color(0xFFF8FFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color(0xFF99CCCC),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFCCFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    iconName,
                    size: 32,
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
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        Divider(color: Color(0xFFCCFFFF)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Début'),
                Text(
                  DateFormat('dd/MM/yy').format(DateTime.parse(startDate)),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fin'),
                Text(
                  DateFormat('dd/MM/yy').format(DateTime.parse(endDate)),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Montant'),
                Text(
                  NumberFormat.currency(
                          locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0)
                      .format(double.parse(targetAmount)),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10), // Space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Etat: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  collectStatus(status),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor(status),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailFundRaisingPage(
                      collectID: collectID,
                      title: title,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: const Color(0xFF2FA9A2),
              ),
              child: Text(
                'Détails',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        LinearPercentIndicator(
          width: 300,
          animation: true,
          lineHeight: 2,
          animationDuration: 1000,
          percent: percent ?? 0,
          barRadius: Radius.circular(4),
          backgroundColor: Color(0xFFCFCFCF),
          progressColor: Color(0xFF3FCB67),
        ),
      ],
    ),
  );
}
