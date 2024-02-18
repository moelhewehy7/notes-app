import 'package:flutter/material.dart';

String knotesbox = "notes_box";
Color kcollor = const Color(0xff62FCD7);
void showsnackbar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 800),
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
    ),
  );
}
