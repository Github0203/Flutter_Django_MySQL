import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/create.dart';
import 'package:frontend/note.dart';
import 'package:frontend/update.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'urls.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<dynamic> notes = [];

  

  List<dynamic> bookList = [];

  void getBooks() async {
    String url = 'http://10.0.2.2:8000/notes/';
    http.Response response = await http.get(Uri.parse(url));
    String val = response.body;
    List<dynamic> data = jsonDecode(val);
    setState(() {
      data.forEach((value) {
        bookList.add(value);
        print(bookList);
      });
    });

    }

  _retrieveNote() async{
    notes = [];
    List response = json.decode((await client.get(Uri.parse('http://10.0.2.2:8000/notes/'))).body);
    for (var element in response) {
      notes.add(Note.fromMap(element));
    }
    
    setState(() {
      
    });
  }
  
  void _addNote(){

  }

  void _deleteNote(String id ){
    client.delete(Uri.parse('http://10.0.2.2:8000/notes/$id/delete/'));
    print('DELETED $id');
    _retrieveNote();
  }

  @override
  void initState() {
    _retrieveNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Django demo'),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
        _retrieveNote();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: () {
                 Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> UpdatePage(
              client: client,
              id: notes[index].id,
              note: notes[index].note,
              ))
          );
              },
              title: Text(notes[index].note.toString()),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteNote(notes[index].id.toString());
                  },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> CreatePage(client: client,))
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
