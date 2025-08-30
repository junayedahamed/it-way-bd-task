import 'package:api_task/src/services/api_services.dart';
import 'package:api_task/src/view/widget/add_task_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body:
          //cheking loading state
          provider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            ) //if true then circular progress indicator
          : provider.error !=
                null //if error is not null
          ? Center(
              child: Text("Error: ${provider.error}"),
            ) //showing error message
          : ListView.builder(
              //if all is ok then build ui of list view
              itemCount: provider
                  .tasks
                  .length, //no of item count is the lenth of my list
              itemBuilder: (context, index) {
                final task = provider.tasks[index]; //taking each data unit
                return SizedBox(
                  height: 120,
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}")),
                        title: Text(task.title),
                        // subtitle: Text(
                        //   "Completed: ${task.completed ? "Yes" : "No"}",
                        // ),
                        // tileColor: task.completed ? Colors.grey : Colors.white,
                        trailing: task.completed
                            ? Icon(Icons.check)
                            : Checkbox(
                                value: task.completed,
                                onChanged: (_) =>
                                    provider.toggleCompleted(task),
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //showing add dialogue
          showDialog(
            context: context,
            builder: (context) {
              return AddTaskDialogue();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
