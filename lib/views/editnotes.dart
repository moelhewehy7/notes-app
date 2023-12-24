import 'package:flutter/material.dart';
import 'package:note_app/customwidget/custom_appbar.dart';

import '../customwidget/textformfield.dart';

class EditNotes extends StatelessWidget {
  const EditNotes({super.key});

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
            onPressed: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          const CustomTextField(
            hint: "title",
          ),
          const SizedBox(
            height: 16,
          ),
          const CustomTextField(
            hint: "content",
            maxLines: 5,
          )
        ],
      ),
    ));
  }
}
