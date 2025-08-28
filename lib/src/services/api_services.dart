import 'dart:convert';
import 'dart:developer';
import 'package:api_task/src/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = []; //List of Task that we will get from api's
  bool _loading = false; //initial loading state
  String? _error; //initial error is null
  //getter method of all private values
  List<Task> get tasks => _tasks;
  bool get loading => _loading;
  String? get error => _error;

  //fetch tasks from api
  Future<void> fetchTasks() async {
    _loading = true; //start of circular indicator by doing loading true
    _error = null;
    notifyListeners();

    try {
      // parsing url for fetching data
      final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
      final response = await http.get(url);
      //checking success status code
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        _tasks = data
            .map((json) => Task.fromJson(json))
            .toList()
            .take(20)
            .toList();
      } else {
        _error = "Failed to load tasks"; //unsuccess  message
      }
    } catch (e) {
      _error = e.toString(); //error message
    }

    _loading = false; //stop of circular indicator by doing loading false
    notifyListeners(); //calling   notifyListeners() for ui change
  }

  //update task status
  Future<void> toggleCompleted(Task task) async {
    final updated = {
      ...task.toJson(),
      "completed": !task.completed,
    }; //finding our updatable task and override it's old value by new value and preparing for put operation

    final url = Uri.parse(
      "https://jsonplaceholder.typicode.com/todos/${task.id}", //updating task by id in db
    );
    final response = await http.put(
      url,
      body: jsonEncode(updated),
    ); //putting payload with url
    // log(response.statusCode.toString());
    //cheking status code is success or not
    if (response.statusCode == 200) {
      //if success then locally chnge the value hence it would not update in DB
      task.completed = !task.completed;
      notifyListeners(); //calling   notifyListeners() for ui change
    }
  }

  Future<void> addTask(String title) async {
    //taking title of todo and making a payload for post
    final newTask = {"userId": 1, "title": title, "completed": false};
    //parsing url
    final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
    //posting new value by http post
    final response = await http.post(url, body: jsonEncode(newTask));
    //checking post status code  (post success code is 201)
    if (response.statusCode == 201) {
      //locally change the list for ui update
      final newtask = Task.fromJson(newTask);
      log(newtask.title);
      _tasks.add(newtask);
      notifyListeners(); //calling   notifyListeners() for ui change
    }
  }
}
