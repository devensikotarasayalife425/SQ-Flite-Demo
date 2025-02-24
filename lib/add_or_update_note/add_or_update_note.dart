import 'package:flutter/material.dart';
import 'package:flutter_sqflite/to_do_list_services/Home.dart';
import 'package:flutter_sqflite/to_do_list_services/to_do_list_model.dart';

import '../Login_Services/sqflite_service.dart';

class AddOrUpdateNote extends StatefulWidget {
  final String appBarTitle;
  final ToDoListModel noteList;

  const AddOrUpdateNote(this.noteList, this.appBarTitle, {super.key});

  @override
  State<AddOrUpdateNote> createState() => _AddOrUpdateNoteState();
}

class _AddOrUpdateNoteState extends State<AddOrUpdateNote> {
  static var priorities = ['High', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper helper = DatabaseHelper();
  ToDoListModel toDoListModel = ToDoListModel();
  DatabaseHelper databaseHelper = DatabaseHelper();

  String dropdownValue = "";
  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.noteList.title!;
    descriptionController.text = widget.noteList.description!;
    if(widget.appBarTitle == "Update Note"){
      dropdownValue = widget.noteList.priority!;
      titleController.text = widget.noteList.title!;
      descriptionController.text = widget.noteList.description!;
      toDoListModel = widget.noteList;
    }else{
      dropdownValue = getPriorityAsString(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              // Write some code to control things, when user press back button in AppBar
              // moveToLastScreen();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // First element
            ListTile(
              title: DropdownButton(
                  items: priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                  value: dropdownValue,
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                      // updatePriorityAsInt(valueSelectedByUser!);
                      dropdownValue = valueSelectedByUser.toString();

                    });
                  }),
            ),

            // Second Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: const TextStyle(fontSize: 14, color: Colors.yellow),
                onChanged: (value) {
                  // debugPrint('Something changed in Title Text Field');
                  // updateTitle();
                  titleController.text = value.toString();
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Third Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: const TextStyle(fontSize: 14, color: Colors.purple),
                onChanged: (value) {
                  debugPrint('Something changed in Description Text Field');
                  // updateDescription();
                  descriptionController.text =value.toString();
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(fontSize: 14, color: Colors.purple),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // Fourth Element
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        
                      ),
                      child: Text(
                        widget.appBarTitle != "Update Note"?'Save':"Update",
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                          toDoListModel.colId = 0;
                          toDoListModel.colEmail= widget.noteList.colEmail;
                          toDoListModel.priority =  dropdownValue.toString();
                          toDoListModel.title =  titleController.text.toString();
                          toDoListModel.description = descriptionController.text.toString();
                          _save(toDoListModel.colEmail! ,dropdownValue.toString(),titleController.text.toString(), descriptionController.text.toString() );
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        
                      ),
                      child: const Text(
                        'Delete',
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Delete button clicked");

                          _delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void moveToLastScreen() {
		Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeView(email:widget.noteList.colEmail!)));
  }


  	void _save(String email, String priority, String title, String description) async {

		int result;
		if (widget.appBarTitle == "Update Note") {
			result = await helper.updateNoteDatabase(toDoListModel);
		} else {
			result = await helper.insertNoteData(email, priority, title, description);
		}

		if (result != 0) {
      print(" NOTE SAVED Successfully");
		} else {
      print(" PROBLEM WHILE SAVING NOTES");

		}
    moveToLastScreen();

	}

  void _delete() async {


		int result;
			result = await helper.deleteNote(toDoListModel.colId!);

		if (result != 0) {  
      print(" NOTE DELETED SUCCEDFULLY");
		} else {  
      print(" PROBLEM WHILE DELETING NOTES");
		}
    moveToLastScreen();

	}


  String getPriorityAsString(int value) {
    String priority='';
    switch (value) {
      case 1:
        priority = priorities[0]; // 'High'
        break;
      case 2:
        priority = priorities[1]; // 'Low'
        break;
    }
    return priority;
  }
}
