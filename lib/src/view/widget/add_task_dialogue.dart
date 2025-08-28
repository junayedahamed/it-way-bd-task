import 'package:api_task/src/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskDialogue extends StatelessWidget {
  AddTaskDialogue({super.key});
  final controller = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Dialog(
        child: SizedBox(
          width: 300,
          height: 250,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add Task"),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please enter a valid title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter task title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          context.read<TaskProvider>().addTask(controller.text);
                          Navigator.pop(context);
                          _key.currentState!.reset();
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
