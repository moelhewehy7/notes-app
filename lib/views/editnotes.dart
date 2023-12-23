import 'package:flutter/material.dart';
import 'package:note_app/customwidget/custom_appbar.dart';

import '../customwidget/textformfield.dart';

class EditNotes extends StatelessWidget {
  const EditNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Column(
        children: [
          CustomAppBar(title: "Edit Note", icon: Icons.save),
          CustomTextField(
            hint: "title",
          ),
          CustomTextField(
            hint: "content",
            maxLines: 5,
          )
        ],
      ),
    );
  }
}
