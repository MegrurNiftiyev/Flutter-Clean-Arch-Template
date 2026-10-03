import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

enum SplashTarget { initial, onboarding, authenticated, unauthenticated }

class SplashState extends Equatable {
  const SplashState({
    this.status = Status.Initial,
    this.target = SplashTarget.initial,
  });

  final Status status;
  final SplashTarget target;

  SplashState copyWith({
    Status? status,
    SplashTarget? target,
  }) {
    return SplashState(
      status: status ?? this.status,
      target: target ?? this.target,
    );
  }

  @override
  List<Object?> get props => [status, target];
}
