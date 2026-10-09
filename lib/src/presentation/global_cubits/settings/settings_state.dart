import 'package:equatable/equatable.dart';

import '../../../core/enums/language_code.dart';
import '../../../core/enums/status.dart';

class SettingsState extends Equatable {
  final Status status;
  final bool isDarkMode;
  final LanguageCode language;

  const SettingsState({
    this.status = Status.initial,
    this.isDarkMode = false,
    this.language = LanguageCode.en,
  });

  SettingsState copyWith({
    Status? status,
    bool? isDarkMode,
    LanguageCode? language,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }

  bool get loggedOut => status == Status.success;

  @override
  List<Object?> get props => [status, isDarkMode, language];
}
