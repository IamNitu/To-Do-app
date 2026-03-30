import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/controller/todo_controller.dart';
import 'package:social_app/screens/pages/add_data/add_todo_page.dart';
import 'package:social_app/screens/pages/homePage/completePage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Tasks"),

        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () => Get.to(() => CompletedPage()),
          ),
        ],
      ),

      body: Column(
        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) =>
                  controller.searchTodo.value = value,
              decoration: const InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // LIST
          Expanded(
            child: Obx(() {
              final list = controller.filterList;

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final todo = list[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: ListTile(
                      // CHECKBOX
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          _showCompleteDialog(context, todo);
                        },
                      ),

                      // TITLE
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todo.isDone
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      subtitle: Text(todo.message),

                      // ACTIONS
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => AddTodoPage(
                                    index: controller.todoList
                                        .indexOf(todo),
                                    title: todo.title,
                                    message: todo.message,
                                  ));
                            },
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () {
                              controller.deleteTodo(todo);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTodoPage()),
        child: const Icon(Icons.add),
      ),
    );
  }

  // CONFIRM DIALOG
  void _showCompleteDialog(BuildContext context, todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Mark as Completed?"),
          content: const Text(
            "This task will move to Completed page.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                controller.toggleTodoDone(todo);

                Navigator.pop(context);

                Get.snackbar(
                  "Completed 🎉",
                  "Task moved to Completed",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}