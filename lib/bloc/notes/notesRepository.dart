import 'package:notes_app/model/notes/NotesResponse.dart';
import 'package:notes_app/services/APIProvider.dart';

class NotesRepository {
  APIProvider apiProvider = APIProvider();

  Future<NotesResponse> getNotes() {
    return apiProvider.getNotes();
  }
}
