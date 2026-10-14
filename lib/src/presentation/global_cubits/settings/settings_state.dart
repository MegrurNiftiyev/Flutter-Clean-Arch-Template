import 'package:equatable/equatable.dart';

import '../../../core/enums/app_region.dart';
import '../../../core/enums/language_code.dart';
import '../../../core/enums/status.dart';

class SettingsState extends Equatable {
  final Status status;
  final bool isDarkMode;
  final LanguageCode language;
  final AppRegion region;

  const SettingsState({
    this.status = Status.initial,
    this.isDarkMode = false,
    this.language = LanguageCode.en,
    this.region = AppRegion.us,
  });

  SettingsState copyWith({
    Status? status,
    bool? isDarkMode,
    LanguageCode? language,
    AppRegion? region,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      region: region ?? this.region,
    );
  }

  bool get loggedOut => status == Status.success;

  @override
  List<Object?> get props => [status, isDarkMode, language, region];
}
