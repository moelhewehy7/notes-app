import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes/features/presentation/widgets/custom_appbar.dart';
import 'package:notes/features/presentation/widgets/edit_text_form_field.dart';
import 'package:notes/helper/show_snackbar.dart';
import '../../../data/models/note_model.dart';
import '../widgets/edit_color_list_view.dart';

class Editnotes extends StatefulWidget {
  const Editnotes({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  State<Editnotes> createState() => _EditnotesState();
}

String? title, content;

class _EditnotesState extends State<Editnotes> {
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
              BlocProvider.of<NotesCubit>(context)
                  .fetchAllnotes(); // to refresh data
              showsnackbar(context, text: "Note updated successfully!");
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
