import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import '../../data/models/note_model.dart';

part 'notes_state.dart';

class notesCubit extends Cubit<notesState> {
  notesCubit() : super(notesInitial());
  List<NoteModel>? notes;
  fetchAllnotes() {
    var notesBox = Hive.box<NoteModel>(knotesbox);
    notes = notesBox.values.toList();
//   // Sort the notes list by date
    notes?.sort((a, b) => b.date.compareTo(a.date));
    emit(notesSuccss());
  }
}
