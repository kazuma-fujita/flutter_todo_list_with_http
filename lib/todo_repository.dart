import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutter_todo_list/todo_api_client.dart';
import 'package:flutter_todo_list/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> fitchList();
  Future<void> createTodo({@required String title});
  Future<void> updateTodo({@required int id, @required String title});
  Future<void> deleteTodo({@required int id});
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({@required this.apiClient});

  final TodoApiClient apiClient;

  static const endPoint = '/todos';

  @override
  Future<List<TodoEntity>> fitchList() async {
    final responseBody = await apiClient.get(endPoint);
    try {
      final decodedJson = json.decode(responseBody) as List<dynamic>;
      return decodedJson
          .map((dynamic itemJson) =>
              TodoEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      throw Exception('Json decode error: $error');
    }
  }

  @override
  Future<void> createTodo({String title}) async {
    final body = {'title': title};
    await apiClient.post(endPoint, body: json.encode(body));
  }

  @override
  Future<void> updateTodo({int id, String title}) async {
    final body = {'title': title};
    await apiClient.put('$endPoint/$id', body: json.encode(body));
  }

  @override
  Future<void> deleteTodo({int id}) async {
    await apiClient.delete('$endPoint/$id');
  }
}
