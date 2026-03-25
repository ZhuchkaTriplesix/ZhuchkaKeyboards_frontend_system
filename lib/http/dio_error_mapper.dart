import 'dart:convert';

import 'package:dio/dio.dart';

import 'system_api_exception.dart';

/// Maps [DioException] to [SystemApiException] using JSON bodies when present
/// (OAuth-style `error` / `error_description`, FastAPI `detail`).
SystemApiException systemApiExceptionFromDio(DioException e) {
  final res = e.response;
  if (res != null) {
    final status = res.statusCode ?? 0;
    final map = _tryJsonMap(res.data);
    if (map.isNotEmpty) {
      final err = map['error']?.toString();
      final desc = map['error_description']?.toString();
      final detail = map['detail'];
      if (err != null && err.isNotEmpty) {
        return SystemApiException(
          desc != null && desc.isNotEmpty ? '$err: $desc' : err,
          status,
        );
      }
      if (detail != null) {
        return SystemApiException(_detailToMessage(detail), status);
      }
      final msg = map['message']?.toString();
      if (msg != null && msg.isNotEmpty) {
        return SystemApiException(msg, status);
      }
    }
    return SystemApiException(e.message ?? 'error', status);
  }
  return SystemApiException(e.message ?? 'network error', 0);
}

String _detailToMessage(dynamic detail) {
  if (detail is String) {
    return detail;
  }
  if (detail is List) {
    return detail.map((e) => e.toString()).join(', ');
  }
  if (detail is Map) {
    return jsonEncode(detail);
  }
  return detail.toString();
}

Map<String, dynamic> _tryJsonMap(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  if (data is String && data.isNotEmpty) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
  }
  return {};
}
