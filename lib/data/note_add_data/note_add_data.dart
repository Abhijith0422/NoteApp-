import 'package:json_annotation/json_annotation.dart';

part 'note_add_data.g.dart';

@JsonSerializable()
class NoteAddData {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;

  NoteAddData({this.id, this.title, this.content});
  NoteAddData.create(
      {required this.id, required this.title, required this.content});

  factory NoteAddData.fromJson(Map<String, dynamic> json) {
    return _$NoteAddDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteAddDataToJson(this);
}
