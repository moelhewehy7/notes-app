part of 'add_note_cubit.dart';

abstract class AddNotesState {}

final class AddNotesInitial extends AddNotesState {}

final class AddNotesLoading extends AddNotesState {}

final class AddNotesSuccss extends AddNotesState {}

final class AddNotesFailure extends AddNotesState {
  final String errmessage;

  AddNotesFailure({required this.errmessage});
}
