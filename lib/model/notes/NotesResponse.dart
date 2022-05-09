// To parse this JSON data, do
//
//     final notesModel = notesModelFromJson(jsonString);

import 'dart:convert';

List<NotesModel> notesModelFromJson(String str) => List<NotesModel>.from(json.decode(str).map((x) => NotesModel.fromJson(x)));

String notesModelToJson(List<NotesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotesModel {
  NotesModel({
    required this.id,
    required this.note,
  });

  int id;
  String note;

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    id: json["id"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note": note,
  };
}
