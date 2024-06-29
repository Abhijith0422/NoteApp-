import 'package:flutter/material.dart';

import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_add_data/note_add_data.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffKey,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('Personal Notes',
            style: TextStyle(color: Color.fromARGB(39, 255, 255, 255))),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                  maxLines: null,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    fillColor: Colors.black26,
                    filled: true,
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              TextFormField(
                  maxLines: null,
                  controller: _contentController,
                  decoration: const InputDecoration(
                    fillColor: Colors.black26,
                    hintText: 'Content',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreenAccent)),
                onPressed: () {
                  saveNote();
                },
                child: const Text('Save',
                    style: TextStyle(color: Color.fromARGB(255, 37, 33, 243))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if ((title.isEmpty || content.isEmpty)) {
      if (title.isEmpty) {
        final note = NoteAddData.create(
            id: DateTime.now().millisecond.toString(),
            title: 'No Title',
            content: content);
        final newnote = await NoteDB().createNote(note);
        if (newnote != null) {
          await NoteDB.instance.getNotes();

          Navigator.of(scaffKey.currentContext!).pop();
        } else {
          return;
        }
      }

      if (content.isEmpty) {
        final note = NoteAddData.create(
            id: DateTime.now().millisecond.toString(),
            title: title,
            content: 'No content');
        final newnote = await NoteDB().createNote(note);
        if (newnote != null) {
          await NoteDB.instance.getNotes();

          Navigator.of(scaffKey.currentContext!).pop();
        } else {
          return;
        }
      }
    } else {
      final note = NoteAddData.create(
          id: DateTime.now().millisecond.toString(),
          title: title,
          content: content);
      final newnote = await NoteDB().createNote(note);
      if (newnote != null) {
        await NoteDB.instance.getNotes();

        Navigator.of(scaffKey.currentContext!).pop();
      } else {
        return;
      }
    }
  }
}
