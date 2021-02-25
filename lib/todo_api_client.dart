import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

abstract class TodoApiClient {
  Future<String> get(String endpoint);
  Future<String> post(String endpoint, {@required String body});
  Future<String> put(String endpoint, {@required String body});
  Future<String> delete(String endpoint);
}

class TodoApiClientImpl implements TodoApiClient {
  // factory コンストラクタは instanceを生成せず常にキャッシュを返す(singleton)
  factory TodoApiClientImpl({String baseUrl = 'http://10.0.2.2:3030'}) {
    return _instance ??= TodoApiClientImpl._internal(baseUrl);
  }
  // クラス生成時に instance を生成する class コンストラクタ
  TodoApiClientImpl._internal(this.baseUrl);
  // singleton にする為の instance キャッシュ
  static TodoApiClientImpl _instance;
  // APIの基底Url
  final String baseUrl;

  static const headers = <String, String>{'content-type': 'application/json'};

  Future<String> _safeApiCall(Function callback) async {
    try {
      final response = await callback() as http.Response;
      return _parseResponse(response.statusCode, response.body);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  @override
  Future<String> get(String endpoint) async {
    return _safeApiCall(() async => http.get('$baseUrl$endpoint'));
  }

  @override
  Future<String> post(String endpoint, {String body}) async {
    return _safeApiCall(() async =>
        http.post('$baseUrl$endpoint', headers: headers, body: body));
  }

  @override
  Future<String> put(String endpoint, {String body}) async {
    return _safeApiCall(() async =>
        http.put('$baseUrl$endpoint', headers: headers, body: body));
  }

  @override
  Future<String> delete(String endpoint) async {
    return _safeApiCall(() async => http.delete('$baseUrl$endpoint'));
  }

  String _parseResponse(int httpStatus, String responseBody) {
    switch (httpStatus) {
      case 200:
      case 201:
        return responseBody;
        break;
      case 400:
        throw Exception('400 Bad Request');
        break;
      case 401:
        throw Exception('401 Unauthorized');
        break;
      case 403:
        throw Exception('403 Forbidden');
        break;
      case 404:
        throw Exception('404 Not Found');
        break;
      case 405:
        throw Exception('405 Method Not Allowed');
        break;
      case 500:
        throw Exception('500 Internal Server Error');
        break;
      default:
        throw Exception('Http status $httpStatus unknown error.');
        break;
    }
  }
}
