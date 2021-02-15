import 'package:flutter_todo_list/todo.dart';
import 'package:flutter_todo_list/todo_state.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoViewModel extends StateNotifier<TodoState> {
  TodoViewModel() : super(const TodoState());

  void createTodo(String title) {
    // 配列のindexをidに設定
    final id = state.todoList.length + 1;
    final newList = [...state.todoList, Todo(id, title)];
    state = state.copyWith(todoList: newList);
  }

  void updateTodo(int id, String title) {
    final newList = state.todoList
        .map((todo) => todo.id == id ? Todo(id, title) : todo)
        .toList();
    state = state.copyWith(todoList: newList);
  }

  void deleteTodo(int id) {
    final newList = state.todoList.where((todo) => todo.id != id).toList();
    state = state.copyWith(todoList: newList);
  }
}
