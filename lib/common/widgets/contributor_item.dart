import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:likya_app/presentation/contributors/datails_contributors.dart';
import 'package:likya_app/utils/utils.dart';

Widget contributorItem(
  String contributorID,
  BuildContext context,
  IconData iconName,
  String contributorName,
  String contributorAmount,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF99CCCC),
            child: Text(
              getInitials(contributorName),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
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
                  contributorName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF336666),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'fr_FR', symbol: 'FCFA', decimalDigits: 0)
                      .format(double.parse(contributorAmount)),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsContributors(
                contributorID: contributorID,
                contributorName: contributorName,
              ),
            ),
          );
        },
        child: Icon(
          iconName,
          color: Color(0xFF007F67),
          size: 18,
        ),
      ),
    ],
  );
}
