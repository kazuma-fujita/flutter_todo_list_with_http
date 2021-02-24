import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// ignore: one_member_abstracts
abstract class TodoApiClient {
  Future<String> get(String endpoint);
}

class TodoApiClientImpl implements TodoApiClient {
  // factory コンストラクタは instanceを生成せず常にキャッシュを返す(singleton)
  factory TodoApiClientImpl({String baseUrl = 'http://localhost:3000'}) {
    return _instance ??= TodoApiClientImpl._internal(baseUrl);
  }
  // クラス生成時に instance を生成する class コンストラクタ
  TodoApiClientImpl._internal(this.baseUrl);
  // singleton にする為の instance キャッシュ
  static TodoApiClientImpl _instance;
  // APIの基底Url
  final String baseUrl;

  @override
  Future<String> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    try {
      final response = await http.get(url);
      return _parseResponse(response.statusCode, response.body);
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  String _parseResponse(int httpStatus, String responseBody) {
    switch (httpStatus) {
      case 200:
        return responseBody;
        break;
      default:
        final decodedJson = json.decode(responseBody) as Map<String, dynamic>;
        throw Exception('$httpStatus ${decodedJson['message']}');
        break;
    }
  }
}
