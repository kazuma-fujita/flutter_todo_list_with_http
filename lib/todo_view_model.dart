import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/todo.dart';

class TodoViewModel extends ChangeNotifier {
  // privateなローカル変数
  List<Todo> _todoList = [];
  // 外から変更不能なListView
  UnmodifiableListView<Todo> get todoList => UnmodifiableListView(_todoList);

  void createTodo(String title) {
    // 配列のindexをidに設定
    final id = _todoList.length + 1;
    _todoList = [...todoList, Todo(id, title)];
    notifyListeners();
  }

  void updateTodo(int id, String title) {
    todoList.asMap().forEach((int index, Todo todo) {
      if (todo.id == id) {
        _todoList[index].title = title;
      }
    });
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todoList = todoList.where((todo) => todo.id != id).toList();
    notifyListeners();
  }
}
