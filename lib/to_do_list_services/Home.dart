import 'package:flutter/material.dart';
import 'package:flutter_sqflite/Login_Services/login_screen.dart';
import 'package:flutter_sqflite/add_or_update_note/add_or_update_note.dart';
import 'package:flutter_sqflite/note_tracker_view/note_tracker_view.dart';
import 'package:flutter_sqflite/shared_preference/shared_preference.dart';
import 'package:flutter_sqflite/to_do_list_services/to_do_list_model.dart';

import '../Login_Services/sqflite_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.email});

  final String email;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ToDoListModel> noteList = [];
  int count = 0;

  @override
  void initState() {
    fetchNoteData();
    super.initState();
  }

  fetchNoteData() {
    final Future dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ToDoListModel>> userListFuture = databaseHelper.getNoteList();
      userListFuture.then((thenNoteList) {
        print("thenNoteList:${thenNoteList}");
        setState(() {
          for (int i = 0; i < thenNoteList.length; i++) {
            if (thenNoteList[i].colEmail == widget.email) {
              noteList.add(thenNoteList[i]);
              count = noteList.length;
            }
          }
        });
      });
    });
  }

  deleteNoteData(int index) {
    final Future dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) async {
      int result = await databaseHelper.deleteNote(noteList[index].colId!);
      if (result != 0) {
        print("Note Deleted Successfully");
        fetchNoteData();
      } else {
        print("PROBLEM WHILE Deleting NOTES");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteTrackerView(
                                toDoListNote: noteList,
                              )));
                },
                icon: const Icon(Icons.track_changes_sharp)),
            IconButton(
                onPressed: () {
                  SharedPreferenceClass pref = SharedPreferenceClass();
                  pref.saveIsLogin(false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
          ),
          body: getNoteListView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint('FAB clicked');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddOrUpdateNote(
                            ToDoListModel(
                                colEmail: widget.email,
                                description: "",
                                priority: "",
                                title: ""),
                            "Add Note",
                          )));
            },
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
        ));
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
                child: Icon(
              noteList[index].priority == "High"
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward,
              color: noteList[index].priority == "High"
                  ? Colors.red
                  : Colors.green,
            )),
            title: Text(
              noteList[index].title!,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              noteList[index].description.toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            trailing: GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                deleteNoteData(index);
                // _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              print("ListTile Tapped");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddOrUpdateNote(noteList[index], "Update Note")));
              // navigateToDetail(this.noteList[position],'Edit Note');
            },
          ),
        );
      },
    );
  }
}
