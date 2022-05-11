class NotesResponse {
  List<NotesData>? notesData;
  bool? success;

  NotesResponse({this.notesData, this.success});

  NotesResponse.fromJson(Map<String, dynamic> json) {
    if (json['notesData'] != null) {
      notesData = <NotesData>[];
      json['notesData'].forEach((v) {
        notesData!.add(NotesData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notesData != null) {
      data['notesData'] = notesData!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class NotesData {
  int? id;
  String? note;

  NotesData({this.id, this.note});

  NotesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    return data;
  }
}
