import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/todo_api_client.dart';

void main() {
  TodoApiClient _apiClient;

  setUp(() async {
    _apiClient = TodoApiClientImpl();
  });

  group('API communication testing', () {
    test('Test of get method.', () async {
      final response = await _apiClient.get('/todos/1');
      print(response);
      const fixtureJson = '''
{
  "id": 1,
  "title": "InitialTask"
}''';
      expect(response, fixtureJson);
    });

    test('Test of post method.', () async {
      final body = {'title': 'SecondTask'};
      final response = await _apiClient.post('/todos', body: json.encode(body));
      print(response);
    });

    test('Test of put method.', () async {
      final body = {'title': 'ChangeTask2'};
      final response =
          await _apiClient.put('/todos/4', body: json.encode(body));
      print(response);
    });

    test('Test of delete method.', () async {
      final response = await _apiClient.delete('/todos/3');
      print(response);
    });
  });

  group('API communication error testing', () {
    test('Test of http 404 not found.', () async {
      expect(() => _apiClient.get('/dummy'), throwsException);
    });

    test('Test of network error', () async {
      expect(() => _apiClient.get('/todos'), throwsException);
    });
  });
}
