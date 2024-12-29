import 'package:flutter/material.dart';

Widget buildImageContainer(
  Color color,
  String title,
  String description,
  String imagePath,
) {
  return Container(
    color: color,
    child: Column(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Color(0xFF007F67),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF353535), fontSize: 17),
          ),
        )
      ],
    ),
  );
}
