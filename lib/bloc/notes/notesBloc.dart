import 'package:notes_app/model/notes/NotesResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'package:notes_app/bloc/notes/notesRepository.dart';

class NotesBloc {
  final notesRepository = NotesRepository();
  final BehaviorSubject<void> _subject = BehaviorSubject<void>();

  getNotes() async {
    var notesResponse = (notesRepository.getNotes());
    _subject.sink.add(notesResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<void> get subject => _subject;
}

final notesBloc = NotesBloc();
