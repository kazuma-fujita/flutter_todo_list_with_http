import 'package:flutter_todo_list/todo_entity.dart';
import 'package:flutter_todo_list/todo_list_view_model.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:meta/meta.dart';

class UpsertTodoViewModel extends StateNotifier<AsyncValue<TodoEntity>> {
  UpsertTodoViewModel(
      {@required this.todoListViewModel, @required this.todoRepository})
      : super(const AsyncValue.data(null));

  final TodoListViewModel todoListViewModel;
  final TodoRepository todoRepository;

  Future<void> createTodo(String title) async {
    // loading処理でstateが上書きされる為、先にstateのvalueを取得する
    // final currentList = state.data.value;
    final currentList = todoListViewModel.state.data.value ?? [];
    state = const AsyncValue.loading();
    try {
      await todoRepository.createTodo(title: title);
      // 配列のindexをidに設定
      final id = currentList.length + 1;
      final todo = TodoEntity(id: id, title: title);
      final newList = [...currentList, todo];
      state = AsyncValue.data(todo);
      todoListViewModel.state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<void> updateTodo(int id, String title) async {
    // final currentList = state.data.value;
    state = const AsyncValue.loading();
    try {
      await todoRepository.updateTodo(id: id, title: title);
      // final newList = currentList
      //     .map(
      //         (todo) => todo.id == id ? TodoEntity(id: id, title: title) : todo)
      //     .toList();
      // state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<void> deleteTodo(int id) async {
    // final currentList = state.data.value;
    state = const AsyncValue.loading();
    try {
      await todoRepository.deleteTodo(id: id);
      // final newList = currentList.where((todo) => todo.id != id).toList();
      // state = AsyncValue.data(newList);
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
