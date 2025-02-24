class ToDoListModel {
  int? colId;
  String? colEmail;
  String? priority;
  String? title;
  String? description;

  ToDoListModel({
    this.colId, this.colEmail,
     this.priority, this.title, this.description});

  ToDoListModel.fromJson(Map<String, dynamic> json) {
    colId = json['id'];
    colEmail = json['email'];
    priority = json['priority'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = colId;
    data['email'] = colEmail;
    data['priority'] = priority;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class ToDoListTrackerDataModel {
  int? colId;
  String? colEmail;
  String? numberOfHighPriorityNote;
  String? numberOfLowPriorityNote;


  ToDoListTrackerDataModel({
    this.colId, this.colEmail,this.numberOfHighPriorityNote, this.numberOfLowPriorityNote });

  ToDoListTrackerDataModel.fromJson(Map<String, dynamic> json) {
    colId = json['trackerId'];
    colEmail = json['email'];
    numberOfHighPriorityNote = json["highPriorityNote"];
    numberOfLowPriorityNote = json["lowPriorityNote"];
  }

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['trackerId'] = colId;
    data['email'] = colEmail;
    data['highPriorityNote'] = numberOfHighPriorityNote;
    data['lowPriorityNote'] = numberOfLowPriorityNote;
    return data;
  }
}
