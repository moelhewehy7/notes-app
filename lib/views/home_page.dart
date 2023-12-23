import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/customwidget/addnotebottomshee.dart';

import '../customwidget/custom_appbar.dart';
import '../customwidget/custome_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                return const AddNoteBottomSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomAppBar(
              title: "Notes",
              icon: Icons.search,
            ),
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  List<double> heights = [
                    400,
                    250,
                  ];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(18, 255, 255, 255)),
                    height: heights[index % heights.length],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          "Flutter widget",
                          style: TextStyle(fontSize: 23),
                        ),
                        subtitle: Text(
                          "build your career with mohamed elhewehy",
                          style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(160, 255, 255, 255)),
                        ),
                        trailing: CustomIcon(
                          icon: Icons.delete,
                        ),
                      ),
                    ), //heights[0 % 2], which equals heights[0] (400)
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
