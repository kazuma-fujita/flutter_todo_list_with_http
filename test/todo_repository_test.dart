import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/todo_api_client.dart';
import 'package:flutter_todo_list/todo_entity.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:mockito/mockito.dart';

import 'fixture.dart';

class MockTodoApiClient extends Mock implements TodoApiClient {}

void main() {
  TodoApiClient _apiClient;
  TodoRepository _todoRepository;

  setUp(() {
    _apiClient = MockTodoApiClient();
    _todoRepository = TodoRepositoryImpl(apiClient: _apiClient);
  });

  group('Todo repository testing', () {
    test('Test of fetch list with empty response.', () async {
      final mockResponse = fixture('empty_response.json');
      when(_apiClient.get(any)).thenAnswer((_) async => mockResponse);
      final todoList = await _todoRepository.fitchList();
      verify(_apiClient.get(any)).called(1);
      expect(
          todoList,
          isA<List<TodoEntity>>()
              .having((list) => list, 'isNotNull', isNotNull)
              .having((list) => list.length, 'length', 0));
    });

    test('Test of fetch list.', () async {
      final mockResponse = fixture('get_response.json');
      when(_apiClient.get(any)).thenAnswer((_) async => mockResponse);
      final todoList = await _todoRepository.fitchList();
      verify(_apiClient.get(any)).called(1);
      expect(
        todoList,
        isA<List<TodoEntity>>()
            .having((list) => list, 'isNotNull', isNotNull)
            .having((list) => list.length, 'length', 3)
            .having((list) => list[0].id, 'id', 1)
            .having((list) => list[0].title, 'title', 'First task')
            .having((list) => list[1].id, 'id', 2)
            .having((list) => list[1].title, 'title', 'Second task')
            .having((list) => list[2].id, 'id', 3)
            .having((list) => list[2].title, 'title', 'Third task'),
      );
    });

    test('Test of create todo.', () async {
      when(_apiClient.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => null);
      await _todoRepository.createTodo(title: 'dummy');
      verify(_apiClient.post(any, body: anyNamed('body'))).called(1);
    });

    test('Test of update todo.', () async {
      when(_apiClient.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => null);
      await _todoRepository.updateTodo(id: 1, title: 'dummy');
      verify(_apiClient.put(any, body: anyNamed('body'))).called(1);
    });

    test('Test of delete todo.', () async {
      when(_apiClient.delete(any)).thenAnswer((_) async => null);
      await _todoRepository.deleteTodo(id: 1);
      verify(_apiClient.delete(any)).called(1);
    });
  });
  group('Todo repository error testing', () {
    test('Test of fetch list with format error json.', () async {
      final mockResponse = fixture('format_error_response.json');
      when(_apiClient.get(any)).thenAnswer((_) async => mockResponse);
      expect(() => _todoRepository.fitchList(), throwsException);
    });
  });
}
