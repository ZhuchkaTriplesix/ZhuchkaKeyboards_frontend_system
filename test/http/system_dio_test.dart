import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:zhuchka_system/http/system_dio.dart';

void main() {
  test('createSystemDio GET succeeds with mock adapter', () async {
    final dio = createSystemDio();
    final adapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = adapter;

    adapter.onGet(
      '/health/live',
      (server) => server.reply(200, <String, dynamic>{'status': 'ok'}),
    );

    final res = await dio.get<Map<String, dynamic>>('/health/live');
    expect(res.statusCode, 200);
    expect(res.data?['status'], 'ok');
  });
}
