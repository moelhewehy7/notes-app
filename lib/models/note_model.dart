import 'package:hive/hive.dart';

part 'note_model.g.dart';
//Dart file name to the part directive, often triggered by the build_runner package

@HiveType(typeId: 0)
//uique per model ,it should be unique for each class marked with @HiveType.

class NoteModel extends HiveObject {
  @HiveField(0)
  //uique per class, Each field that is going to be stored needs a unique HiveField identifier.
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final int color;

  NoteModel(
      {required this.title,
      required this.content,
      required this.date,
      required this.color});
}
