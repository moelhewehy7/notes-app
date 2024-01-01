import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());
  Color color = const Color(0xFF546E7A);
  addnote(NoteModel note) async {
    emit(AddNotesLoading());
    await Future.delayed(const Duration(
        milliseconds: 1000)); //to assure that loading has a chance to display
    note.color = color.value;
    try {
      var notebox = Hive.box<NoteModel>(knotesbox);
      await notebox.add(note);
      emit(AddNotesSuccss());
    } on Exception catch (e) {
      emit(AddNotesFailure(errmessage: e.toString()));
    }
  }
}
