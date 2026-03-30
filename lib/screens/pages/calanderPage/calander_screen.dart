import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calander_controller.dart';

class CalanderScreen extends StatelessWidget {
  const CalanderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalanderController());
    final TextEditingController todoController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar Tasks"),
      ),

      body: Obx(() {
        return Column(
          children: [
            // CALENDAR
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: controller.focusedDay.value,

              selectedDayPredicate: (day) =>
                  isSameDay(controller.selectedDate.value, day),

              onDaySelected: (selectedDay, focusedDay) {
                controller.changeDate(selectedDay);
              },
            ),

            const SizedBox(height: 10),

            // ADD-TODO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: const InputDecoration(
                        hintText: "Add Todo...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      if (todoController.text.isNotEmpty) {
                        controller.addTodo(todoController.text);
                        todoController.clear();
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // LIST
            Expanded(
              child: Obx(() {
                final list = controller.getTodos();

                if (list.isEmpty) {
                  return const Center(
                    child: Text("No todos for this date"),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final todo = list[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: const Icon(Icons.circle_outlined),

                        title: Text(todo),

                        onTap: () {
                          _showCompleteDialog(
                              context, controller, todo);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  // PROFESSIONAL DIALOG
  void _showCompleteDialog(
    BuildContext context,
    CalanderController controller,
    String todo,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          title: const Text("Mark as Completed?"),

          content: const Text(
            "This task will move to Completed list.",
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
                controller.completeTodo(todo);

                Navigator.pop(context);

                Get.snackbar(
                  "Completed 🎉",
                  "Task moved to completed",
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