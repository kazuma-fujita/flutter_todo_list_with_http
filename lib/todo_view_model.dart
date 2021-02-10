import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/todo.dart';

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  // List<Todo> fetchTodoList() => [];

  void createTodo(String title) {
    // とりあえず配列のindexをidに設定
    final id = _todoList.length + 1;
    _todoList = [...todoList, Todo(id, title)];
    notifyListeners();
  }

  void updateTodo(int id, String title) {
    print('updateTodo id: $id title: $title');
    todoList.asMap().forEach((int index, Todo todo) {
      if (todo.id == id) {
        _todoList[index].title = title;
      }
    });
    notifyListeners();
  }

  void deleteTodo(int id) {
    print('deleteTodo id: $id');
    _todoList = todoList.where((todo) => todo.id != id).toList();
    print(_todoList.toString());
    notifyListeners();
  }
}
