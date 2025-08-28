import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TaskModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  TaskModel copyWith({int? userId, int? id, String? title, bool? completed}) =>
      TaskModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
