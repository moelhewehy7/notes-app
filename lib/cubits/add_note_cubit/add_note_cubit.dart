import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());

  addnote(NoteModel note) async {
    emit(AddNotesLoading());
    try {
      var notebox = Hive.box<NoteModel>(Knotesbox);
      emit(AddNotesSuccss());
      await notebox.add(note);
    } on Exception catch (e) {
      emit(AddNotesFailure(errmessage: e.toString()));
      // TODO
    }
  }
}
