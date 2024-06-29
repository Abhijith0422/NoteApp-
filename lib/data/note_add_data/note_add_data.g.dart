// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_add_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteAddData _$NoteAddDataFromJson(Map<String, dynamic> json) => NoteAddData(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NoteAddDataToJson(NoteAddData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
