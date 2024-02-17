import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/presentation/customwidget/color_item.dart';
import 'package:note_app/features/presentation/customwidget/editcolorlistview.dart';

import '../../../cubits/add_note_cubit/add_note_cubit.dart';

class ColorListView extends StatefulWidget {
  const ColorListView({super.key});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

int currentIndex = 0;
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
                    index, //means it will be white if index numbuer= current one
              ),
            ),
          );
        },
      ),
    );
  }
}
