import 'dart:io';

import 'package:flutter/material.dart';

String getInitials(String name) {
  List<String> words = name.trim().split(' ');

  if (words.length >= 2) {
    return words[0][0].toUpperCase() + words[1][0].toUpperCase();
  } else if (words.length == 1) {
    return words[0][0].toUpperCase();
  } else {
    return '';
  }
}

String collectStatus(status) {
  switch (status) {
    case 'reject':
      return 'Rejetée';
    case 'validate':
      return 'Validée';
    case 'completed':
      return 'Complètée';
    case 'in progress':
      return 'En cours';
    default:
      return 'En attente';
  }
}

Color statusColor(String status) {
  switch (status) {
    case 'reject':
      return Color(0xFFFF0000);
    case 'validate':
      return Color(0xFF00FF00);
    case 'completed':
      return Color(0xFF0000FF);
    case 'in progress':
      return Color(0xFFFF8C00);
    default:
      return Color(0xFFFFA500);
  }
}

Widget userAvatar(userName, imgPatch, double radius, double fontSize) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Color(0xFF03544F),
    backgroundImage: imgPatch != null ? FileImage(File(imgPatch)) : null,
    child: imgPatch == null
        ? Text(
            getInitials(userName),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Righteous',
            ),
          )
        : null,
  );
}
