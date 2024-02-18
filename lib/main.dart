import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:Notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:Notes/features/presentation/views/simpleblocobserver.dart';

import 'constants.dart';
import 'data/models/note_model.dart';
import 'features/presentation/views/splash_view.dart';

void main() async {
  await Hive.initFlutter(); //dontforget hive flutter not just hive
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(knotesbox); //dont forget the type

  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
// /*  */