import 'package:flutter_todo_list/todo_entity.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:meta/meta.dart';

class TodoViewModel extends StateNotifier<AsyncValue<List<TodoEntity>>> {
  TodoViewModel({@required this.todoRepository})
      : super(const AsyncValue.loading()) {
    _fetchList();
  }

  final TodoRepository todoRepository;

  Future<void> _fetchList() async {
    state = const AsyncValue.loading();
    try {
      final newList = await todoRepository.fitchList();
      state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<void> createTodo(String title) async {
    state = const AsyncValue.loading();
    try {
      await todoRepository.createTodo(title: title);
      // 配列のindexをidに設定
      final id = state.data.value.length + 1;
      final newList = [...state.data.value, TodoEntity(id: id, title: title)];
      state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<void> updateTodo(int id, String title) async {
    state = const AsyncValue.loading();
    try {
      await todoRepository.updateTodo(id: id, title: title);
      final newList = state.data.value
          .map(
              (todo) => todo.id == id ? TodoEntity(id: id, title: title) : todo)
          .toList();
      state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<void> deleteTodo(int id) async {
    state = const AsyncValue.loading();
    try {
      await todoRepository.deleteTodo(id: id);
      final newList = state.data.value.where((todo) => todo.id != id).toList();
      state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
