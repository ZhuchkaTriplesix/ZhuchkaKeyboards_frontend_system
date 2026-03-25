import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:zhuchka_system/http/dio_error_mapper.dart';
import 'package:zhuchka_system/http/system_api_exception.dart';

void main() {
  test('maps FastAPI detail string', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://mock.test'));
    final adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;

    adapter.onGet(
      '/x',
      (server) => server.reply(
        422,
        <String, dynamic>{'detail': 'validation failed'},
      ),
    );

    try {
      await dio.get<Object>('/x');
      fail('expected DioException');
    } on DioException catch (e) {
      final ex = systemApiExceptionFromDio(e);
      expect(ex, isA<SystemApiException>());
      expect(ex.message, 'validation failed');
      expect(ex.statusCode, 422);
    }
  });

  test('maps OAuth-style error and description', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://mock.test'));
    final adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;

    adapter.onGet(
      '/x',
      (server) => server.reply(
        400,
        <String, dynamic>{
          'error': 'invalid_request',
          'error_description': 'Missing field',
        },
      ),
    );

    try {
      await dio.get<Object>('/x');
      fail('expected DioException');
    } on DioException catch (e) {
      final ex = systemApiExceptionFromDio(e);
      expect(ex.message, 'invalid_request: Missing field');
      expect(ex.statusCode, 400);
    }
  });

  test('network error maps to status 0', () {
    final ex = systemApiExceptionFromDio(
      DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionError,
        message: 'Socket failed',
      ),
    );
    expect(ex.statusCode, 0);
    expect(ex.message, contains('Socket'));
  });
}
