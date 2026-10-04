import 'base_exception.dart';

sealed class SettingsException extends BaseException {
  const SettingsException(super.message, [super.statusCode]);

  static final Map<int, SettingsException Function(String?)> expected = {};
}
