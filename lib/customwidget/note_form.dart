import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/models/note_model.dart';

import '../constants.dart';
import 'button.dart';
import 'textformfield.dart';

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
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hint: 'Title',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (value) {
              content = value;
            },
            maxLines: 5,
            hint: 'Content',
          ),
          const SizedBox(
            height: 32,
          ),
          BlocConsumer<AddNotesCubit, AddNotesState>(
            listener: (context, state) {
              if (state is AddNotesSuccss) {
                // Handle successful note addition (e.g., show success message or navigate)
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Note added successfully!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color.fromARGB(255, 48, 48, 48),
                  ),
                );
                Navigator.pop(context);
              } else if (state is AddNotesFailure) {
                // Handle error (e.g., display error message)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color.fromARGB(255, 48, 48, 48),
                  ),
                );
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
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      var notemodel = NoteModel(
                        title: title!,
                        content: content!,
                        color: Colors.blue.value,
                        date: DateTime.now().toString(),
                      );
                      BlocProvider.of<AddNotesCubit>(context)
                          .addnote(notemodel);
                    } else {
                      autovalidate = AutovalidateMode.always;
                    }
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
}
