import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:intl/intl.dart';

import '../views/editnotes.dart';
import 'custome_icon.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.height, required this.note});

  final double height;
  final NoteModel note;
  late String text = note.title;
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,

                  text.substring(0, 3),
                  // Ensure only a single line is displayed
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                CustomIcon(
                  onPressed: () {
                    note.delete();
                  },
                  icon: Icons.delete,
                ),
              ],
            ),
            const SizedBox(height: 4), // Adjust spacing as needed
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(160, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(height: 8), // Adjust spacing as needed
            Text(DateFormat('MMM d h:mm a').format(DateTime.parse(note.date))),
          ],
        ),
      ),
    );
  }
}
