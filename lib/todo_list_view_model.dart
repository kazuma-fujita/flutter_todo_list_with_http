import 'package:flutter_todo_list/todo_entity.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:meta/meta.dart';

class TodoListViewModel extends StateNotifier<AsyncValue<List<TodoEntity>>> {
  TodoListViewModel({@required this.todoRepository})
      : super(const AsyncValue.loading()) {
    fetchList();
  }

  final TodoRepository todoRepository;

  Future<void> fetchList() async {
    await _tryCatch(() async {
      final newList = await todoRepository.fitchList();
      state = AsyncValue.data(newList);
    });
  }

  Future<void> deleteTodo(int id) async {
    if (state is AsyncError) {
      state = AsyncValue.error('There is an error in the list.');
      return;
    }
    final currentList = state.data.value;
    await _tryCatch(() async {
      await todoRepository.deleteTodo(id: id);
      final newList = currentList.where((todo) => todo.id != id).toList();
      state = AsyncValue.data(newList);
    });
  }

  Future<void> _tryCatch(Function callback) async {
    state = const AsyncValue.loading();
    try {
      await callback();
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
