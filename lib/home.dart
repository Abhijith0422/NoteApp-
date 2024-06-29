import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_add_data/note_add_data.dart';
import 'package:note_app/pages/add.dart';

import 'package:note_app/pages/note.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDB.instance.getNotes();
    });
    return Scaffold(
      appBar: AppBar(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(1)),
        backgroundColor: Colors.black26,
        title: const Text(
          'Personal Notes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ValueListenableBuilder(
            valueListenable: NoteDB.instance.noteListNotifier,
            builder: (context, List<NoteAddData> notes, _) {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: List.generate(
                  notes.length,
                  (index) {
                    final note = NoteDB.instance.noteListNotifier.value[index];
                    if (note.id == null) {
                      return const SizedBox();
                    }

                    return NoteItem(
                      title: note.title ?? 'No Title',
                      content: note.content ?? 'No content',
                      id: note.id!,
                      index: index,
                    );
                  },
                ),
              );
            }),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
