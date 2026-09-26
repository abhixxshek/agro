import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../app/config/api_config.dart';
import 'api_exception.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> get _defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, String>? queryParams}) async {
    try {
      Uri uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await _client.get(
        uri,
        headers: {..._defaultHeaders, ...?headers},
      ).timeout(ApiConfig.connectionTimeout);

      return _processResponse(response);
    } on SocketException {
      throw ApiException('No internet connection or server unreachable.');
    } on http.ClientException catch (e) {
      throw ApiException('Network request failed: ${e.message}');
    }
  }

  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body, Map<String, String>? headers}) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final response = await _client
          .post(
            uri,
            headers: {..._defaultHeaders, ...?headers},
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.connectionTimeout);

      return _processResponse(response);
    } on SocketException {
      throw ApiException('No internet connection or server unreachable.');
    } on http.ClientException catch (e) {
      throw ApiException('Network request failed: ${e.message}');
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) return {};
        return jsonDecode(response.body);
      case 400:
        final body = jsonDecode(response.body);
        throw ApiException(body['error'] ?? body['message'] ?? 'Bad Request', statusCode: 400);
      case 401:
        throw ApiException('Unauthorized access. Please login again.', statusCode: 401);
      case 404:
        throw ApiException('Resource not found on server.', statusCode: 404);
      case 500:
        throw ApiException('Internal server error. Please try again later.', statusCode: 500);
      default:
        throw ApiException('Unexpected server response (${response.statusCode})', statusCode: response.statusCode);
    }
  }
}
