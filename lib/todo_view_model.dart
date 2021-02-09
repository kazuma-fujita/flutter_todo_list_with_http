import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/todo.dart';

class TodoViewModel extends ChangeNotifier {
  final List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  List<Todo> fetchTodoList() => todoList;

  void createTodo(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }
}
