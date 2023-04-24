import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'main.dart';

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdatePage({super.key, required this.client, required this.id, required this.note});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  initState(){
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
          ElevatedButton(
            onPressed: () {
              widget.client.put(Uri.parse('http://10.0.2.2:8000/notes/${widget.id}/update/'), body:{'body': controller.text});
               Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> const MyHomePage(
              ))
          );
            }, 
            child: const Text('Update Note'))
        ],
      )
    );
  }
}