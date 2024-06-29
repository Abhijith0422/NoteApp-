import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/get_all/get_all.dart';
import 'package:note_app/data/note_add_data/note_add_data.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCall {
  Future<NoteAddData?> createNote(NoteAddData value);
  Future<List<NoteAddData>> getNotes();
  Future<NoteAddData?> updateNote(NoteAddData value);

  Future<void> deletenote(String id);
}

class NoteDB extends ApiCall {
  NoteDB.internal();
  static NoteDB instance = NoteDB.internal();
  NoteDB factory() {
    return instance;
  }

  final dio = Dio();
  final url = Url();
  ValueNotifier<List<NoteAddData>> noteListNotifier = ValueNotifier([]);
  NoteDB() {
    dio.options =
        BaseOptions(baseUrl: url.baseUrl, responseType: ResponseType.plain);
  }
  @override
  Future<NoteAddData?> createNote(NoteAddData value) async {
    final response = await dio.post(url.addNote, data: value.toJson());
    final resultAsJson = jsonDecode(response.data);
    final note = NoteAddData.fromJson(resultAsJson as Map<String, dynamic>);
    NoteDB.instance.noteListNotifier.value.insert(0, note);
    noteListNotifier.notifyListeners();
    return note;
  }

  @override
  Future<void> deletenote(String id) async {
    final result =
        await dio.delete(url.baseUrl + url.deleteNote.replaceFirst('{id}', id));
    if (result.data == null) {
      return;
    }
    final index = noteListNotifier.value.indexWhere((note) => note.id == id);
    if (index == -1) {
      return;
    } else {
      noteListNotifier.value.removeAt(index);
      noteListNotifier.notifyListeners();
      return result.data;
    }
  }

  @override
  Future<List<NoteAddData>> getNotes() async {
    final response = await dio.get(url.baseUrl + url.getNotes);
    if (response.data != null) {
      final resultasjson =
          response.data is String ? jsonDecode(response.data) : response.data;
      final getNoteResp = GetAll.fromJson(resultasjson);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNoteResp.data.reversed);

      noteListNotifier.notifyListeners();

      return getNoteResp.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<NoteAddData?> updateNote(NoteAddData value) async {
    final response =
        await dio.put(url.baseUrl + url.updateNote, data: value.toJson());
    if (response.data != null) {
      final index =
          noteListNotifier.value.indexWhere((note) => note.id == value.id);
      if (index == -1) {
        return null;
      } else {
        noteListNotifier.value.removeAt(index);
        noteListNotifier.value.insert(index, value);
        noteListNotifier.notifyListeners();
        return value;
      }
    } else {
      return null;
    }
  }

  NoteAddData? getNotebyid(String id) {
    try {
      return noteListNotifier.value.firstWhere(
        (element) => element.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}
