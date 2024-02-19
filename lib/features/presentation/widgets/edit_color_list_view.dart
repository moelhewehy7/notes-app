import 'package:flutter/material.dart';
import 'package:notes/features/presentation/widgets/color_item.dart';

import '../../../data/models/note_model.dart';

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
    const Color(0xFF073A53), // Blue Grey
    const Color(0xFF846300), // Amber
    const Color(0xFF823821), // Deep Orange
    const Color(0xFF86009E), // Purple
    const Color(0xFF8D6E63), // Brown
    const Color(0xFF37474F), // Darker shades of Blue Grey
    const Color(0xFF1E2875), // Darker shades of Indigo
    const Color(0xFF7B1414), // Darker shades of Red
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
