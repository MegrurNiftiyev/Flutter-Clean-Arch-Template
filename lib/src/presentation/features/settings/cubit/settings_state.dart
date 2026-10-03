import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

class SettingsState extends Equatable {
  final Status status;
  final bool isDarkMode;
  final String languageCode;
  final String? errorMessage;
  final bool isLoggedOut;

  const SettingsState({
    this.status = Status.Initial,
    this.isDarkMode = false,
    this.languageCode = 'en',
    this.errorMessage,
    this.isLoggedOut = false,
  });

  SettingsState copyWith({
    Status? status,
    bool? isDarkMode,
    String? languageCode,
    String? errorMessage,
    bool? isLoggedOut,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      errorMessage: errorMessage,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isDarkMode,
        languageCode,
        errorMessage,
        isLoggedOut,
      ];
}
