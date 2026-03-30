class TodoModel {
  String title;
  String message;
  bool isDone;
  DateTime? completedAt;

  TodoModel({
    required this.title,
    required this.message,
    this.isDone =false,
    this.completedAt
  });
}