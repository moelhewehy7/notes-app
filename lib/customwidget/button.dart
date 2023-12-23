import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35, // Takes the width of the screen
      decoration: BoxDecoration(
        color: Color(0xff62FCD7),
        borderRadius:
            BorderRadius.circular(8.0), // Optional: Adds rounded corners
        border: Border.all(color: Colors.black), // Optional: Adds a border
      ),
      child: Text(
        'Save',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
