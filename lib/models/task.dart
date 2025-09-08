class Task {
  Task({required this.title, this.done = false, this.note, this.due});
  String title;
  bool done;
  String? note;
  DateTime? due;
}

enum TaskFilter { all, pending, done }
