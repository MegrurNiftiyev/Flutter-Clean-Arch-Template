import 'package:equatable/equatable.dart';

import '../../../../core/enums/splash_target.dart';
import '../../../../core/enums/status.dart';
import '../../../../core/exceptions/base_exception.dart';

class SplashState extends Equatable {
  final Status status;
  final SplashTarget? target;
  final BaseException? exception;

  const SplashState({
    this.status = Status.initial,
    this.target,
    this.exception,
  });

  SplashState copyWith({
    Status? status,
    SplashTarget? target,
    BaseException? exception,
  }) {
    return SplashState(
      status: status ?? this.status,
      target: target ?? this.target,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [status, target, exception];
}
