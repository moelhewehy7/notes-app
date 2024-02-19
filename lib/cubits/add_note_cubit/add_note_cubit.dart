import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/constants.dart';

import '../../data/models/note_model.dart';

part 'add_note_state.dart';

class AddnotesCubit extends Cubit<AddnotesState> {
  AddnotesCubit() : super(AddnotesInitial());
  Color color = const Color(0xFF546E7A);
  addnote(NoteModel note) async {
    emit(AddnotesLoading());
    await Future.delayed(const Duration(
        milliseconds: 1000)); //to assure that loading has a chance to display

    try {
      var notebox = Hive.box<NoteModel>(knotesbox);
      await notebox.add(note);
      emit(AddnotesSuccss());
    } on Exception catch (e) {
      emit(AddnotesFailure(errmessage: e.toString()));
    }
  }
}
