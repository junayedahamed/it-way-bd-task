import 'package:api_task/src/api_services/fetch_service/fetch_bloc.dart';
import 'package:api_task/src/api_services/fetch_service/fetch_event.dart';
import 'package:api_task/src/api_services/fetch_service/fetch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskFetchBloc taskFetch = TaskFetchBloc();
  @override
  void initState() {
    taskFetch.add(InitialFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskFetchBloc, TaskFetchState>(
        bloc: taskFetch,
        builder: (context, state) {
          switch (state.runtimeType) {
            case FetchLodingState():
              return Center(child: CircularProgressIndicator());

            case FetchCompleteState():
              final data = state as FetchCompleteState;

              return ListView.builder(
                itemCount: data.tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(tileColor: Colors.red);
                },
              );
            case FetchErrorState():
              return Center(child: Text("Error Occoured"));
            default:
              return SizedBox();
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
