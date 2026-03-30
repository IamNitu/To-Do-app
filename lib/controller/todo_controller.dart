import 'package:get/get.dart';
import 'package:social_app/model/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <TodoModel>[].obs;
  var searchTodo = "".obs;
  var selectedTodos = <int>{}.obs;

  // ACTIVE
  List<TodoModel> get activeTodos =>
      todoList.where((t) => !t.isDone).toList();

  // COMPLETED
  List<TodoModel> get completeTodos =>
      todoList.where((t) => t.isDone).toList();

  // SEARCH
  List<TodoModel> get filterList {
    if (searchTodo.value.isEmpty) return activeTodos;

    final query = searchTodo.value.toLowerCase();

    return activeTodos.where((todo) {
      return todo.title.toLowerCase().contains(query) ||
          todo.message.toLowerCase().contains(query);
    }).toList();
  }

  // ADD
  void addTodo(String title, String message) {
    todoList.add(
      TodoModel(
        title: title,
        message: message,
        isDone: false,
      ),
    );
  }

  // DELETE
  void deleteTodo(TodoModel todo) {
    todoList.remove(todo);
  }

  // EDIT
  void editTodo(int index, String title, String message) {
    todoList[index].title = title;
    todoList[index].message = message;
    todoList.refresh();
  }

  // SELECT
  void toggleSelection(TodoModel todo) {
    final index = todoList.indexOf(todo);

    if (selectedTodos.contains(index)) {
      selectedTodos.remove(index);
    } else {
      selectedTodos.add(index);
    }
  }

  // BULK DELETE
  void deleteSelectedTodos() {
    todoList.removeWhere((todo) {
      return selectedTodos.contains(todoList.indexOf(todo));
    });

    selectedTodos.clear();
  }

  // MARK AS COMPLETED (FIXED)
  void toggleTodoDone(TodoModel todo) {
    final index = todoList.indexOf(todo);

    if (index == -1) return;

    todoList[index].isDone = true;
    todoList[index].completedAt = DateTime.now();

    todoList.refresh(); 
  }
}