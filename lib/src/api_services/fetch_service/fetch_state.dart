import 'package:api_task/src/model/task_model.dart';

abstract class TaskFetchState {}

class FetchInitialState extends TaskFetchState {}

class FetchLodingState extends TaskFetchState {}

class FetchErrorState extends TaskFetchState {}

class FetchCompleteState extends TaskFetchState {
  final List<TaskModel> tasks;
  FetchCompleteState({required this.tasks});
}
