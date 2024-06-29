import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_add_data/note_add_data.dart';

class EditPage extends StatelessWidget {
  final _scaffKey = GlobalKey<ScaffoldState>();
  final String title, id, content;
  final TextEditingController _titleController, _contentController;

  EditPage({
    super.key,
    required this.title,
    required this.id,
    required this.content,
  })  : _titleController = TextEditingController(text: title),
        _contentController = TextEditingController(text: content);

  @override
  Widget build(BuildContext context) {
    _titleController.text = title;
    _contentController.text = content;
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          style: const TextStyle(
              color: Color.fromARGB(39, 255, 255, 255), fontSize: 20),
          title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
                controller: _titleController,
                maxLines: null,
                decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0))),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  textAlignVertical: TextAlignVertical.top,
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'Content',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0))),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveEditedNote();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<void> saveEditedNote() async {
    final _title = _titleController.text;
    final _content = _contentController.text;

    final editedNote =
        NoteAddData.create(id: id, title: _title, content: _content);
    final note = await NoteDB.instance.updateNote(editedNote);
    if (note != null) {
      Navigator.of(_scaffKey.currentContext!).pop();
    } else {
      return;
    }
  }
}
