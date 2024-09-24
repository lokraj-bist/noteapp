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

  loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? notesJson = sp.getStringList('notes');
    if (notesJson != null) {
      setState(() {
        _list = notesJson
            .map((note) => notes.fromJson(json.decode(note)))
            .toList(); 
      });
    }
  }

  saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> noteJson = _list
        .map((note) => json.encode(note.toJson()))
        .toList(); 
    sp.setStringList('notes', noteJson); 
  }

  
  Future<void> navigateToAddNoteScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()), 
    );

    if (result != null && result is notes) {
      setState(() {
        _list.add(result); 
      });
      saveData(); 
    }
  }

  deleteData(int index) {
    setState(() {
      _list.removeAt(index);
      saveData(); 
    });
  }

  @override
  void initState() {
    loadData(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: _list.isEmpty?Center(child: Text('Empty'),) : ListView.builder(
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
