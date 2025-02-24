import 'dart:io';
import 'package:flutter_sqflite/to_do_list_services/to_do_list_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'user_login_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String idCol = "id";

  String toDoListTableName = "note_table";
  String emailCol = "email";
  String notePriorityCol = "priority";
  String noteTitleCol = "title";
  String noteDescCol = "description";

  String trackerTableIddCol = "trackerId";
  String toDoNoteTracerTableName = "note_tracker_table";
  String numberOfHighPriorityNotesCol= "highPriorityNote";
  String numberOfLowPriorityNotesCol= "lowPriorityNote";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

    Future<Database> get database async {

		_database ??= await initializeDatabase();
		return _database!;
	}

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}sqflite.db";
    var userDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
      await db.execute(
          "CREATE TABLE $toDoListTableName($idCol INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$emailCol TEXT, $notePriorityCol TEXT, $noteTitleCol TEXT, $noteDescCol TEXT)");
      await db.execute(
          "CREATE TABLE $toDoNoteTracerTableName($trackerTableIddCol INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,$emailCol TEXT, $numberOfHighPriorityNotesCol TEXT, $numberOfLowPriorityNotesCol TEXT)");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
		Database db = await database;

		var result = await db.query(toDoListTableName, );
    print("result:${result}");
		return result;
	}



  Future<List<ToDoListModel>> getNoteList()async{
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<ToDoListModel> noteList = [];
    for(int i = 0; i < count; i++){
      noteList.add(ToDoListModel.fromJson(noteMapList[i]));
    }
    return noteList;
  }


    Future<int> insertNoteData(String email, String priority, String title, String description ) async {
    Database db = await database;
    var data = { emailCol:email ,notePriorityCol: priority, noteTitleCol: title, noteDescCol:description };
    var result =
        await db.insert(toDoListTableName, data);
    return result;
  }

    Future<int> updateNoteDatabase(ToDoListModel toDoListModel) async {

    var db = await database;
    var result = await db.update(toDoListTableName, toDoListModel.toMap(),
        where: "$emailCol = ?", whereArgs: [toDoListModel.colEmail]);
    print("result:$result");
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await database;
    int result =
        await db.rawDelete("DELETE FROM $toDoListTableName WHERE $idCol = $id");
    return result;
  }

  Future<List<Map<String, dynamic>>> getNoteTrackerMapData() async {
    Database db = await database;

    var result = await db.query(toDoNoteTracerTableName, );
    print("result:${result}");
    return result;
  }


  Future<List<ToDoListTrackerDataModel>> getNoteTrackerData()async{
    var noteTrackerMapData = await getNoteTrackerMapData();
    int count = noteTrackerMapData.length;
    List<ToDoListTrackerDataModel> noteTrackerData = [];
    for(int i = 0; i < count; i++){
      noteTrackerData.add(ToDoListTrackerDataModel.fromJson(noteTrackerMapData[i]));
    }
    return noteTrackerData;
  }

  Future<int> insertNoteTrackerData(String email, String numberOfHighPriorityNotes, String numberOfLowPriorityNotes ) async {
    Database db = await database;
    var data = { emailCol:email ,numberOfHighPriorityNotes:numberOfHighPriorityNotes, numberOfLowPriorityNotesCol: numberOfLowPriorityNotes };
    var result =
    await db.insert(toDoNoteTracerTableName, data);
    return result;
  }

  Future<int> updateNoteTrackerDatabase(ToDoListTrackerDataModel toDoListTrackerDataModel) async {

    var db = await database;
    var result = await db.update(toDoNoteTracerTableName, toDoListTrackerDataModel.toMap(),
        where: "$emailCol = ?", whereArgs: [toDoListTrackerDataModel.colEmail]);
    print("result:$result");
    return result;
  }

  Future<int> deleteNoteTracker(int id) async {
    var db = await database;
    int result =
    await db.rawDelete("DELETE FROM $toDoNoteTracerTableName WHERE $idCol = $id");
    return result;
  }

}
