import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';

// ignore: must_be_immutable
class ContentPage extends StatelessWidget {
  final String title;
  const ContentPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          style: const TextStyle(color: Colors.white, fontSize: 20),
          title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: List.generate(
            1,
            (index) {
              final note = NoteDB.instance.noteListNotifier.value[index];

              if (note.id == null) {
                return const SizedBox();
              }
              return Text(
                note.content ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          ),
        ),
      ),
    );
  }
}
