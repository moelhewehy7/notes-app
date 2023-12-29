part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesSuccss extends NotesState {
  final List<NoteModel> notes;

  NotesSuccss({required this.notes});
}

final class NotesFailure extends NotesState {
  final String errmessage;

  NotesFailure({required this.errmessage});
}
