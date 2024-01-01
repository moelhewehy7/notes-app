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
            height: 15,
          ),
          const ColorListView(),
          const SizedBox(
            height: 15,
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

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});
  final bool isActive;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: color,
            ),
          )
        : CircleAvatar(
            radius: 30,
            backgroundColor: color,
          );
  }
}

class ColorListView extends StatefulWidget {
  const ColorListView({super.key});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

int CurrentIndex = 0;
List<Color> noteColors = [
  Color(0xFFE48989)!, // Light gray
  Colors.blue[200]!, // Light blue
  Colors.green[200]!, // Light green
  Colors.purple[200]!, // Light purple
  Colors.blueAccent, // Blue accent
  Colors.greenAccent, // Green accent
  Colors.amberAccent, // Amber accent
  Colors.indigoAccent, // Indigo accent
  Colors.blue[900]!, // Darker shades of blue
  Colors.green[800]!, // Darker shades of green
  Colors.deepPurple, // Deep purple
  Colors.red[800]!, // Darker shades of red
];

class _ColorListViewState extends State<ColorListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                CurrentIndex = index;
                setState(() {});
              },
              child: ColorItem(
                color: noteColors[index],
                isActive: CurrentIndex ==
                    index, //means it will be white if for the index numbver
              ),
            ),
          );
        },
      ),
    );
  }
}
