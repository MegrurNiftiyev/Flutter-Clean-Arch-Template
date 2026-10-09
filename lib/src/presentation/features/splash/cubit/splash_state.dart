import 'package:equatable/equatable.dart';

import '../../../../core/enums/splash_target.dart';
import '../../../../core/enums/status.dart';

class SplashState extends Equatable {
  final Status status;
  final SplashTarget? target;
  final String? errorMessage;

  const SplashState({
    this.status = Status.initial,
    this.target,
    this.errorMessage,
  });

  SplashState copyWith({
    Status? status,
    SplashTarget? target,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      target: target ?? this.target,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, target, errorMessage];
}
