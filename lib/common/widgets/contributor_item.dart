import 'package:flutter/material.dart';
import 'package:likya_app/data/source/api_service.dart';
import 'package:likya_app/utils/utils.dart';

Widget contributorItem(
  List<String> contributorNames,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: contributorNames.map((contributorName) {
      return FutureBuilder<String?>(
        future: ApiService().listContributors(contributorName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF99CCCC),
                  child: Text(
                    getInitials(
                      snapshot.data ?? 'No data available',
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Righteous',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  snapshot.data ?? 'No data available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )
              ],
            );
          } else {
            return Text('No data available');
          }
        },
      );
    }).toList(),
  );
}
