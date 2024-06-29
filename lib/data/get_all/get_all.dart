import 'package:json_annotation/json_annotation.dart';
import 'package:note_app/data/note_add_data/note_add_data.dart';

part 'get_all.g.dart';

@JsonSerializable()
class GetAll {
  @JsonKey(name: 'data')
  List<NoteAddData> data;

  GetAll({this.data = const []});

  factory GetAll.fromJson(Map<String, dynamic> json) {
    return _$GetAllFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllToJson(this);
}
