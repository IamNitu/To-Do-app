import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/todo_controller.dart';

class CompletedPage extends StatelessWidget {
  CompletedPage({super.key});

  final TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Completed Tasks")),

      body: Obx(() {
        final list = controller.completeTodos;

        if (list.isEmpty) {
          return const Center(child: Text("No completed tasks"));
        }

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final todo = list[index];

            return ListTile(
              title: Text(todo.title),
              subtitle: Text(
                "Completed: ${todo.completedAt}",
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.blue
              ),
            );
          },
        );
      }),
    );
  }
}