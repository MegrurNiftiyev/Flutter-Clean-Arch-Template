import 'package:dio/dio.dart';

import '../exceptions/base_exception.dart';
import '../exceptions/network_exceptions.dart';
import 'exception_mapper.dart';
import '../network/api_response.dart';

Future<T> executeRequest<T>(
  Future<Response> Function() apiCall, {
  T Function(Object? json)? fromJson,
  ErrorFactories expected = const {},
}) async {
  try {
    final response = await apiCall();
    if (fromJson != null) {
      final apiResponse = ApiResponse<T>.fromJson(
        response.data as Map<String, dynamic>,
        fromJson,
      );
      return apiResponse.data as T;
    }
    return null as T;
  } on BaseException {
    rethrow;
  } on DioException catch (e, st) {
    Error.throwWithStackTrace(mapDioException(e, expected), st);
  } catch (e, st) {
    Error.throwWithStackTrace(UnknownException(e.toString()), st);
  }
}
