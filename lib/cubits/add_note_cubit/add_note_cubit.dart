import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit() : super(AddNotesInitial());

  addnote(NoteModel note) async {
    emit(AddNotesLoading());
    await Future.delayed(Duration(
        milliseconds: 1000)); //to assure that loading has a chance to display
    try {
      var notebox = Hive.box<NoteModel>(Knotesbox);
      await notebox.add(note);
      emit(AddNotesSuccss());
    } on Exception catch (e) {
      emit(AddNotesFailure(errmessage: e.toString()));
      // TODO
    }
  }
}
