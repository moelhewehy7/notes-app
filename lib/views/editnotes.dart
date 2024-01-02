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
            height: 16,
          ),
          CustomTextField(
            onChanged: (value) {
              title = value;
            },
            initialValue: widget.noteModel.title,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onChanged: (value) {
              content = value;
            },
            initialValue: widget.noteModel.content,
            maxLines: 5,
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

class EditColorListView extends StatefulWidget {
  const EditColorListView({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  State<EditColorListView> createState() => _ColorListViewState();
}

@override
@override
class _ColorListViewState extends State<EditColorListView> {
  late int currentIndex;
  List<Color> noteColors = [
    const Color(0xFF546E7A), // Dark Blue Gray
    Colors.blueGrey[300]!, // Blue Grey
    const Color.fromARGB(255, 132, 99, 0), // Amber
    Colors.deepOrange[400]!, // Deep Orange
    Colors.purple[400]!, // Purple
    Colors.brown[400]!, // Brown
    Colors.blueGrey[800]!, // Darker shades of Blue Grey
    Colors.indigo[800]!, // Darker shades of Indigo
    Colors.red[800]!, // Darker shades of Red
  ];
  @override
  void initState() {
    currentIndex = noteColors.indexOf(Color(widget.noteModel.color));
    super.initState();
  }

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
                widget.noteModel.color = noteColors[index].value;

                setState(() {});
              },
              child: ColorItem(
                color: noteColors[index],
                isActive: currentIndex ==
                    index, //means it will be white if for the index numbver
              ),
            ),
          );
        },
      ),
    );
  }
}
