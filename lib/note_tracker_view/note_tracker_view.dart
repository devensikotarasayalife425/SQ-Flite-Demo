import 'package:flutter/material.dart';
import 'package:flutter_sqflite/to_do_list_services/to_do_list_model.dart';

class NoteTrackerView extends StatefulWidget {
  const NoteTrackerView({super.key, required this.toDoListNote});

  final List<ToDoListModel> toDoListNote;

  @override
  State<NoteTrackerView> createState() => _NoteTrackerViewState();
}

class _NoteTrackerViewState extends State<NoteTrackerView> {
  bool isLoading = false;

  @override
  void initState() {
    fetchNoteTrackerData();
    super.initState();
  }

  fetchNoteTrackerData() async {
    setState(() {
      isLoading = true;
    });



    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Note Tracker Screen",
          style: TextStyle(
              color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const CircularProgressIndicator(
              color: Colors.black,
            )
          : Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: widget.toDoListNote.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.toDoListNote[index].colEmail}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
