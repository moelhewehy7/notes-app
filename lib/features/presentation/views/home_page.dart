import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/features/presentation/customwidget/show_modal_bottom_sheet_body.dart';

import '../../../data/models/note_model.dart';
import '../customwidget/custom_container.dart';
import '../customwidget/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

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
              height: 20,
            ),
            CustomAppBar(
              title: "Notes",
              icon: Icons.search,
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
                    physics: const BouncingScrollPhysics(),
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int i) {
                      List<double> heights = [
                        height * 0.3,
                        height * 0.25,
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomContainer(
                          note: notes[i],
                          height: heights[i % heights.length],
                          // when you perform (i mod 2),
                          //  the result will always be either 0 or 1
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
