import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/customwidget/addnotebottomshee.dart';

import '../customwidget/container.dart';
import '../customwidget/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                context: context,
                builder: (context) {
                  return const AddNoteBottomSheet();
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomAppBar(
                title: "Notes",
                icon: Icons.search,
                onPressed: () {},
              ),
              Expanded(
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    List<double> heights = [
                      250,
                      200,
                    ];
                    return CustomContainer(
                      height: heights[index % heights.length],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
