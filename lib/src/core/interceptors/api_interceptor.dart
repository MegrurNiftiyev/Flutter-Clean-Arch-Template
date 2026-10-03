import 'package:dio/dio.dart';

/// Custom Dio interceptor for handling app-level request/response logic.
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Add dynamic headers or authentication tokens if needed
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: Handle global response formatting or logging if needed
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: Handle global network errors or refresh tokens
    super.onError(err, handler);
  }
}
