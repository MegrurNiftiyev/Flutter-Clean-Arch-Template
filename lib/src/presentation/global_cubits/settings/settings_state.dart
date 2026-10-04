import 'package:equatable/equatable.dart';

import '../../../core/enums/status.dart';
import '../../../core/exceptions/base_exception.dart';

class SettingsState extends Equatable {
  final Status status;
  final bool isDarkMode;
  final String languageCode;
  final BaseException? exception;

  const SettingsState({
    this.status = Status.initial,
    this.isDarkMode = false,
    this.languageCode = 'en',
    this.exception,
  });

  SettingsState copyWith({
    Status? status,
    bool? isDarkMode,
    String? languageCode,
    BaseException? exception,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      exception: exception,
    );
  }

  bool get loggedOut => status == Status.success;

  @override
  List<Object?> get props => [status, isDarkMode, languageCode, exception];
}
