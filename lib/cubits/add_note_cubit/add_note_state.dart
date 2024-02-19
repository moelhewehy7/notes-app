part of 'add_note_cubit.dart';

abstract class AddnotesState {}

final class AddnotesInitial extends AddnotesState {}

final class AddnotesLoading extends AddnotesState {}

final class AddnotesSuccss extends AddnotesState {}

final class AddnotesFailure extends AddnotesState {
  final String errmessage;

  AddnotesFailure({required this.errmessage});
}
