class UserLoginModel {
  int? id;
  String? username;
  UserLoginModel(
      this.id,
    this.username,
  );
  UserLoginModel.fromMap(dynamic obj) {
    id = obj['id'] ?? 0;
    username = obj['username'] ?? "";
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["username"] = username;
    return map;
  }
}
