import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prueba_1/models/task.dart';

enum TaskFilter { all, pending, done }

class TaskController extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      title: "ir a comprar pan",
      done: true,
      note: "No olvides la lista",
      due: DateTime.now().add(Duration(days: 1)),
    ),
  ];

  String _query = "";
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks => List.unmodifiable(_tasks);
  String get query => _query;

  List<Task> get filtered {
    final q = _query.toLowerCase();
    return _tasks.where((t) {
      final byfilter =
          (_filter == TaskFilter.all) ||
          (_filter == TaskFilter.pending && !t.done) ||
          (_filter == TaskFilter.done && t.done);

      final byquery =
          t.title.toLowerCase().contains(q) ||
          (t.note?.toLowerCase().contains(q) ?? false);

      return byfilter && byquery;
    }).toList();
  }

  String? get title => null;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setFilter(TaskFilter f) {
    _filter = f;
    notifyListeners();
  }

  void toggle(Task t, bool v) {
    t.done = v;
    notifyListeners();
  }

  void add(String title, String note, DateTime? due) {
    _tasks.insert(0, Task(title: title, note: note, due: due));
    notifyListeners();
  }

  void remove(Task t) {
    _tasks.remove(t);
    notifyListeners();
  }
}
