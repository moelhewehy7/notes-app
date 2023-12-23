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
        return EditNotes();
      })),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(18, 255, 255, 255)),
        height: height,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Flutter widget",
                      // Ensure only a single line is displayed
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    CustomIcon(
                      icon: Icons.delete,
                    )
                  ],
                ),
                SizedBox(height: 4), // Adjust spacing as needed
                Text(
                  "build your career with Mohamed Elhewehy",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(160, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 8), // Adjust spacing as needed

                Text("November 12")
              ],
            ),
          ),
        ), //heights[0 % 2], which equals heights[0] (400)
      ),
    );
  }
}
