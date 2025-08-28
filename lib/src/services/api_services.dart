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
}
