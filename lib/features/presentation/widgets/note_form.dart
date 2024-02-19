import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notes/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes/features/presentation/widgets/add_text_form_field.dart';
import 'package:notes/features/presentation/widgets/add_color_list_view.dart';
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
          BlocConsumer<AddnotesCubit, AddnotesState>(
            listener: (context, state) {
              if (state is AddnotesSuccss) {
                BlocProvider.of<notesCubit>(context).fetchAllnotes();
                showsnackbar(context, text: 'Note added successfully!');
                Navigator.pop(context);
              } else if (state is AddnotesFailure) {
                showsnackbar(context, text: state.errmessage);
              }
            },
            builder: (context, state) {
              if (state is AddnotesLoading) {
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
        color: BlocProvider.of<AddnotesCubit>(context)
            .color
            .value, //or note.color = color.value; in add note cubit
        date: DateTime.now().toString(),
      );
      BlocProvider.of<AddnotesCubit>(context).addnote(notemodel);
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
