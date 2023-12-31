import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/customwidget/custom_appbar.dart';
import 'package:note_app/models/note_model.dart';

import '../customwidget/textformfield.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  State<EditNotes> createState() => _EditNotesState();
}

String? title, content;

class _EditNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomAppBar(
            title: "Edit Note",
            icon: Icons.done,
            onPressed: () {
              widget.noteModel.title = title ?? widget.noteModel.title;
              widget.noteModel.content = content ?? widget.noteModel.content;
              widget.noteModel.save();
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Note updated successfully!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Color.fromARGB(255, 48, 48, 48),
                ),
              );
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onChanged: (value) {
              title = value;
            },
            initialValue: widget.noteModel!.title,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onChanged: (value) {
              content = value;
            },
            initialValue: widget.noteModel!.content,
            maxLines: 5,
          )
        ],
      ),
    ));
  }
}
