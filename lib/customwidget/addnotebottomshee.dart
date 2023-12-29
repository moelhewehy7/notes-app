import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'note_form.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //we used BlocProvider her to use less resources and check bloc observer prints u will see it open when i open modal sheet and close when i close it
      create: (context) => AddNotesCubit(),
      child: BlocBuilder<AddNotesCubit, AddNotesState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddNotesLoading ? true : false,
            // Using the ternary operator (? :) to conditionally set the value is concise and effective
            child: Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: SingleChildScrollView(child: Noteform())),
          );
        },
      ),
    );
  }
}
