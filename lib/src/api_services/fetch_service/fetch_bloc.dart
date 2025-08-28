import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:api_task/src/model/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:api_task/src/api_services/fetch_service/fetch_event.dart';
import 'package:api_task/src/api_services/fetch_service/fetch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskFetchBloc extends Bloc<FetchTaskEvent, TaskFetchState> {
  TaskFetchBloc() : super(FetchInitialState()) {
    on<InitialFetch>(initialFetchData);
  }

  FutureOr<void> initialFetchData(
    InitialFetch event,
    Emitter<TaskFetchState> emit,
  ) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    final List<TaskModel> tasks = [];
    emit(FetchLodingState());
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        for (var i = 0; i < data.length; i++) {
          final task = TaskModel.fromJson(data[i]);

          tasks.add(task);
        }
      }

      emit(FetchCompleteState(tasks: tasks));

      log(tasks.toString());
    } catch (e) {
      emit(FetchErrorState());
      log(e.toString());
    }
  }
}
