import 'package:flutter/material.dart';
import 'package:notes_app/model/notes/NotesResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'package:notes_app/bloc/notes/notesRepository.dart';

class NotesBloc {
  final notesRepository = NotesRepository();
  final BehaviorSubject<NotesResponse> _subject =
      BehaviorSubject<NotesResponse>();

  getNotes() async {
    var notesResponse = await notesRepository.getNotes();
    debugPrint('Notes length :: $notesResponse');
    _subject.sink.add(notesResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<NotesResponse> get subject => _subject;
}

final notesBloc = NotesBloc();
