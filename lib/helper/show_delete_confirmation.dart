import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helper/show_snackbar.dart';

import '../cubits/notes_cubit/notes_cubit.dart';
import '../data/models/note_model.dart';

void showDeleteConfirmationDialog(BuildContext context,
    {required NoteModel notemodel}) {
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
              notemodel.delete();
              BlocProvider.of<NotesCubit>(context).fetchAllnotes();
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
