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
    await _tryCatch(() async {
      await todoRepository.createTodo(title: title);
      final currentList = todoListViewModel.state.data.value;
      final id = currentList.length + 1;
      final newTodo = TodoEntity(id: id, title: title);
      final newList = [...currentList, newTodo];
      todoListViewModel.state = AsyncValue.data(newList);
      state = AsyncValue.data(newTodo);
    });
  }

  Future<void> updateTodo(int id, String title) async {
    await _tryCatch(() async {
      await todoRepository.updateTodo(id: id, title: title);
      final currentList = todoListViewModel.state.data.value;
      final newTodo = TodoEntity(id: id, title: title);
      final newList =
          currentList.map((todo) => todo.id == id ? newTodo : todo).toList();
      todoListViewModel.state = AsyncValue.data(newList);
      state = AsyncValue.data(newTodo);
    });
  }

  Future<void> _tryCatch(Function callback) async {
    if (todoListViewModel.state is AsyncError) {
      state = AsyncValue.error('There is an error in the list.');
      return;
    }
    state = const AsyncValue.loading();
    try {
      await callback();
    } on Exception catch (error) {
      state = AsyncValue.error(error);
    }
  }
}
