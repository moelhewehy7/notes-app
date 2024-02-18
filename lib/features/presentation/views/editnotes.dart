import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:Notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:Notes/features/presentation/widgets/custom_appbar.dart';
import 'package:Notes/features/presentation/widgets/edit_text_form_field.dart';
import '../../../data/models/note_model.dart';
import '../widgets/editcolorlistview.dart';

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
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 22,
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
                  duration: Duration(milliseconds: 800),
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
            height: 8,
          ),
          EditCustomTextField(
            fontSize: 28,
            hint: "Title",
            onChanged: (value) {
              title = value;
            },
            initialValue: widget.noteModel.title,
          ),
          Text(
            DateFormat('MMMM d h:mm a')
                .format(DateTime.parse(widget.noteModel.date)),
            style: const TextStyle(color: Color(0x93FFFFFF)),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: EditCustomTextField(
              hint: "Start Typing",
              onChanged: (value) {
                content = value;
              },
              initialValue: widget.noteModel.content,
              maxLines: 5,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          EditColorListView(noteModel: widget.noteModel)
        ],
      ),
    ));
  }
}
