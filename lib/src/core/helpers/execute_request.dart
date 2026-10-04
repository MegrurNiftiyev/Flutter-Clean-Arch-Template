import 'package:dio/dio.dart';

import '../exceptions/base_exception.dart';
import '../exceptions/network_exceptions.dart';
import 'exception_mapper.dart';

Future<T> executeRequest<T>(
  Future<T> Function() apiCall, {
  ErrorFactories expected = const {},
}) async {
  try {
    return await apiCall();
  } on BaseException {
    rethrow;
  } on DioException catch (e, st) {
    Error.throwWithStackTrace(mapDioException(e, expected), st);
  } catch (e, st) {
    Error.throwWithStackTrace(UnknownException(e.toString()), st);
  }
}
