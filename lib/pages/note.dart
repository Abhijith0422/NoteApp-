import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/pages/content.dart';
import 'package:note_app/pages/editpage.dart';

class NoteItem extends StatelessWidget {
  final String title;
  final String content;
  final String id;
  final int index;
  // final String date;
  const NoteItem({
    super.key,
    required this.title,
    required this.content,
    required this.id,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return EditPage(
            title: title,
            id: id,
            content: content,
          );
        }));
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return ContentPage(title: title);
        }));
      },
      child: Column(
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.start,
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        NoteDB.instance.deletenote(id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                Text(
                  textAlign: TextAlign.start,
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
