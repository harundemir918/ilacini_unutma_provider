import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.users,
    this.count,
  });

  List<User> users;
  int count;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "count": count,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.password,
    this.devicePlayerId,
    this.type,
    this.createDate,
  });

  String id;
  String name;
  String surname;
  String username;
  String password;
  String devicePlayerId;
  String type;
  DateTime createDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    username: json["username"],
    password: json["password"],
    devicePlayerId: json["device_player_id"],
    type: json["type"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "username": username,
    "password": password,
    "device_player_id": devicePlayerId,
    "type": type,
    "create_date": createDate.toIso8601String(),
  };
}
