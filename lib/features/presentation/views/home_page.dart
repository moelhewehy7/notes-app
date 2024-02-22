import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes/features/presentation/widgets/show_modal_bottom_sheet_body.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../data/models/note_model.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllnotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              context: context,
              builder: (context) {
                return const ShowModalBottomSheetBody();
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 22,
            ),
            CustomAppBar(
              title: "Notes",
              icon: Icons.edit,
              onPressed: () {},
            ),
            BlocBuilder<NotesCubit, NotesState>(
              builder: (context, state) {
                List<NoteModel> notes =
                    BlocProvider.of<NotesCubit>(context).notes ?? [];
                return Expanded(
                    child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const BouncingScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomContainer(
                      note: notes[index],
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
