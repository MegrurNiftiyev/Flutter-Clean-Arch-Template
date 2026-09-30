import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = Status.initial,
  });

  final Status status;

  SettingsState copyWith({
    Status? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
