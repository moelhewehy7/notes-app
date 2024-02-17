import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import '../../data/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  List<NoteModel>? notes;
  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(knotesbox);
    notes = notesBox.values.toList();
//   // Sort the notes list by date
    notes?.sort((a, b) => b.date.compareTo(a.date));
    emit(NotesSuccss());
  }
}
