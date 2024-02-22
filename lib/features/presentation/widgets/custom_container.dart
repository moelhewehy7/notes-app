import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/helper/show_delete_confirmation.dart';
import '../../../data/models/note_model.dart';
import '../views/editnotes.dart';
import 'custome_icon.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.note});
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Editnotes(noteModel: note);
      })),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(note.color),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis, note.title,
                    // Expanded widget around the Text widget to ensure
                    //the text takes up all available space in the row and to prevent overflow errors.
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomIcon(
                  onPressed: () {
                    showDeleteConfirmationDialog(context, notemodel: note);
                  },
                  icon: Icons.delete,
                ),
              ],
            ),
            // Adjust spacing as needed
            Padding(
              padding: EdgeInsets.only(right: width * .15, bottom: 2),
              child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(239, 224, 224, 224),
                ),
              ),
            ),
            // Adjust spacing as needed
            Text(
              DateFormat('MMM d h:mm a').format(DateTime.parse(note.date)),
              style: const TextStyle(color: Color.fromARGB(221, 199, 199, 199)),
            ),
          ],
        ),
      ),
    );
  }
}
