import 'package:flutter/material.dart';

import '../views/editnotes.dart';
import 'custome_icon.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const EditNotes();
      })),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(18, 255, 255, 255),
        ),
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Flutter widget",
                  // Ensure only a single line is displayed
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                CustomIcon(
                  onPressed: () {},
                  icon: Icons.delete,
                ),
              ],
            ),
            const SizedBox(height: 4), // Adjust spacing as needed
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "build your career with Mohamed Elhewehy",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(160, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 8), // Adjust spacing as needed
            const Text("November 12"),
          ],
        ),
      ),
    );
  }
}
