import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../data/models/note_model.dart';
import '../views/editnotes.dart';
import 'custome_icon.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.height, required this.note});

  final double height;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
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
        height: height,
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
                    //or we could do that without expanded
                    //late String text = note.title;
                    // text.length <= 12 ? text : '${text.substring(0, 12)}...',,
                    // Ensure only a single line is displayed
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                CustomIcon(
                  onPressed: () {
                    showDeleteConfirmationDialog(context);
                  },
                  icon: Icons.delete,
                ),
              ],
            ),
            // Adjust spacing as needed
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(160, 255, 255, 255),
                ),
              ),
            ),
            // Adjust spacing as needed
            Text(DateFormat('MMM d h:mm a').format(DateTime.parse(note.date))),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this note'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                note.delete();
                BlocProvider.of<notesCubit>(context).fetchAllnotes();
                Navigator.of(context).pop(); // Close the dialog
                // Show a SnackBar to confirm deletion
                showsnackbar(context, text: 'Note deleted');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
