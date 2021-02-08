import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/todo.dart';

class TodoViewModel extends ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  List<Todo> fetchTodoList() => todos;

  void createTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
