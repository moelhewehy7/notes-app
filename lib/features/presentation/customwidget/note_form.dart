import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/features/presentation/customwidget/add_text_form_field.dart';
import 'package:note_app/features/presentation/customwidget/add_color_list_view.dart';
import '../../../constants.dart';
import '../../../data/models/note_model.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class Noteform extends StatefulWidget {
  const Noteform({
    super.key,
  });

  @override
  State<Noteform> createState() => _NoteformState();
}

class _NoteformState extends State<Noteform> {
  AutovalidateMode autovalidate = AutovalidateMode.disabled;

  final GlobalKey<FormState> formkey = GlobalKey();

  String? title, content;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidate,
      key: formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
          ),
          AddCustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: 'Title',
          ),
          const SizedBox(
            height: 16,
          ),
          AddCustomTextField(
            onSaved: (value) {
              content = value;
            },
            maxLines: 5,
            hint: 'Content',
          ),
          const SizedBox(
            height: 15,
          ),
          const ColorListView(),
          const SizedBox(
            height: 15,
          ),
          BlocConsumer<AddNotesCubit, AddNotesState>(
            listener: (context, state) {
              if (state is AddNotesSuccss) {
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                showsnackbar(context, text: 'Note added successfully!');
                Navigator.pop(context);
              } else if (state is AddNotesFailure) {
                showsnackbar(context, text: state.errmessage);
              }
            },
            builder: (context, state) {
              if (state is AddNotesLoading) {
                return SpinKitCircle(
                  color: kcollor,
                  size: 20.0,
                );
              } else {
                return CustomButton(
                  onpressed: () async {
                    addnotemethod(context);
                  },
                  // Conditionally display a loading indicator if needed
                );
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void addnotemethod(BuildContext context) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      var notemodel = NoteModel(
        title: title!,
        content: content!,
        color: BlocProvider.of<AddNotesCubit>(context)
            .color
            .value, //or note.color = color.value; in add note cubit
        date: DateTime.now().toString(),
      );
      BlocProvider.of<AddNotesCubit>(context).addnote(notemodel);
    } else {
      autovalidate = AutovalidateMode.always;
    }
  }

  void showsnackbar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      ),
    );
  }
}
