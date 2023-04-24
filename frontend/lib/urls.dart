
import 'package:http/http.dart' as http;

class ServiceAPI {
  // ignore: non_Stringant_identifier_names
  static Future<String> ViewAllNote() async {
    String url = 'http://10.0.2.2:8000/notes';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
  static Future<String> DeleteNote(String id) async {
    String url = 'http://10.0.2.2:8000/$id/delete/';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}

String getNotes = 'http://10.0.2.2:8000/notes/';
String addNotes = 'http://10.0.2.2:8000/notes/';
String updateNote = 'http://10.0.2.2:8000/notes/update/';
String deleteNote = 'http://10.0.2.2:8000/notes/delete/';
