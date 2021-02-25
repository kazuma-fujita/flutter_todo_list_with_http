import 'package:flutter_todo_list/todo_entity.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:meta/meta.dart';

class TodoListViewModel extends StateNotifier<AsyncValue<List<TodoEntity>>> {
  TodoListViewModel({@required this.todoRepository})
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

  // Future<void> createTodo(String title) async {
  //   // loading処理でstateが上書きされる為、先にstateのvalueを取得する
  //   final currentList = state.data.value;
  //   state = const AsyncValue.loading();
  //   try {
  //     await todoRepository.createTodo(title: title);
  //     // 配列のindexをidに設定
  //     final id = currentList.length + 1;
  //     final newList = [...currentList, TodoEntity(id: id, title: title)];
  //     state = AsyncValue.data(newList);
  //   } on Exception catch (error) {
  //     state = AsyncValue.error(error);
  //   }
  // }
  //
  // Future<void> updateTodo(int id, String title) async {
  //   final currentList = state.data.value;
  //   state = const AsyncValue.loading();
  //   try {
  //     await todoRepository.updateTodo(id: id, title: title);
  //     final newList = currentList
  //         .map(
  //             (todo) => todo.id == id ? TodoEntity(id: id, title: title) : todo)
  //         .toList();
  //     state = AsyncValue.data(newList);
  //   } on Exception catch (error) {
  //     state = AsyncValue.error(error);
  //   }
  // }
  //
  Future<void> deleteTodo(int id) async {
    final currentList = state.data.value;
    state = const AsyncValue.loading();
    try {
      await todoRepository.deleteTodo(id: id);
      final newList = currentList.where((todo) => todo.id != id).toList();
      state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
