import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
// import 'package:noteaapp/models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noteaapp/models/notes.dart';
import 'dart:convert';
import 'package:noteaapp/screens/addnotes.dart';

class notess extends StatefulWidget {

  _appState createState() => _appState();

}

class _appState extends State<notess>{
  List<notes> _list = [];

  // Load saved data
  loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? notesJson = sp.getStringList('notes');
    if (notesJson != null) {
      setState(() {
        _list = notesJson
            .map((note) => notes.fromJson(json.decode(note)))
            .toList(); // Convert saved JSON data back into model objects
      });
    }
  }

  // Save current list of notes
  saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> noteJson = _list
        .map((note) => json.encode(note.toJson()))
        .toList(); // Convert notes to JSON format
    sp.setStringList('notes', noteJson); // Save the list as strings
  }

  // Navigate to AddNoteScreen and handle result
  Future<void> navigateToAddNoteScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()), // Go to AddNoteScreen
    );

    if (result != null && result is notes) {
      setState(() {
        _list.add(result); // Add new note to the list
      });
      saveData(); // Save data after adding
    }
  }

  // Delete a note
  deleteData(int index) {
    setState(() {
      _list.removeAt(index);
      saveData(); // Save updated list after deleting
    });
  }

  @override
  void initState() {
    loadData(); // Load saved data when app starts
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => splash()));
            },
            icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blueAccent,
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: Column(
        children: [
        Expanded(
          child: _list.isEmpty?Center(child: CupertinoActivityIndicator(),) : ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(_list[index].title),
                subtitle: Text(_list[index].description),
                leading: CircleAvatar(child: Text('${index}'),),
                trailing: IconButton(onPressed: (){deleteData(index);}, icon: Icon(Icons.delete)),
              );
            },
          ),
        )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        navigateToAddNoteScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
