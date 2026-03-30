import 'package:get/get.dart';
import 'package:social_app/controller/todo_controller.dart';
import 'package:social_app/model/todo_model.dart';

class CalanderController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  var todos = <DateTime, List<String>>{}.obs;

  // CONNECT MAIN CONTROLLER
  final TodoController mainController = Get.find();

  void changeDate(DateTime date) {
    selectedDate.value = date;
    focusedDay.value = date;
  }

  DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void addTodo(String text) {
    final date = _normalize(selectedDate.value);

    if (todos.containsKey(date)) {
      todos[date]!.add(text);
    } else {
      todos[date] = [text];
    }

    todos.refresh();
  }

  List<String> getTodos() {
    final date = _normalize(selectedDate.value);
    return todos[date] ?? [];
  }

  // FIXED METHOD
  void completeTodo(String text) {
    final date = _normalize(selectedDate.value);

    // remove from calendar
    todos[date]?.remove(text);

    // ADD TO MAIN TODO_CONTROLLER
    mainController.todoList.add(
      TodoModel(
        title: text,
        message: "From Calendar",
        isDone: true,
        completedAt: DateTime.now(),
      ),
    );

    todos.refresh();
    mainController.todoList.refresh();
  }
}