import 'package:flutter/material.dart';

class EditCustomTextField extends StatelessWidget {
  const EditCustomTextField(
      {super.key,
      this.hint,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      this.initialValue});

  final String? hint;
  final int maxLines;
  final String? initialValue;

  final void Function(String?)? onSaved;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          //and if value is not empty but null, it also returns Text("try again").
          return 'Field is required ';
        } else {
          return null;
        }
      },
      cursorColor: const Color(0xff62FCD7),
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
      ),
    );
  }
}
