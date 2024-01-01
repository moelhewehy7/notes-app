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
                    duration: Duration(milliseconds: 800),
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
                    duration: Duration(milliseconds: 800),
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
                        color:
                            BlocProvider.of<AddNotesCubit>(context).color.value,
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

int currentIndex = 0;
List<Color> noteColors = [
  const Color(0xFF546E7A), // Dark Blue Gray
  Color(0xFF073A53), // Blue Grey
  Color(0xFF846300), // Amber
  Color(0xFFFF7043), // Deep Orange
  Color(0xFFAB47BC), // Purple
  Color(0xFF8D6E63), // Brown
  Color(0xFF37474F), // Darker shades of Blue Grey
  Color.fromARGB(255, 30, 40, 117), // Darker shades of Indigo
  Color(0xFFC62828), // Darker shades of Red
];

class _ColorListViewState extends State<ColorListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: noteColors.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                currentIndex = index;
                BlocProvider.of<AddNotesCubit>(context).color =
                    noteColors[index];
                setState(() {});
              },
              child: ColorItem(
                color: noteColors[index],
                isActive: currentIndex ==
                    index, //means it will be white if for the index numbuer
              ),
            ),
          );
        },
      ),
    );
  }
}
