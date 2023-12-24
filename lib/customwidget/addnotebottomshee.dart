import 'package:flutter/material.dart';

import 'button.dart';
import 'textformfield.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Noteform(),
      ),
    );
  }
}

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
          CustomButton(
            onTap: () {
              if (formkey.currentState!.validate()) {
                return formkey.currentState!.save();
              } else {
                autovalidate = AutovalidateMode.always;
                //ensures that the validators are triggered as the user interacts with the form fields
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
